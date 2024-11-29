import uuid
from pathlib import Path
from flask import Blueprint, render_template, current_app, send_from_directory, redirect, url_for, flash, request, jsonify
from apps.app import db
from apps.crud.models import User
from apps.sns.models import Image,Post,Follow,Comment
from apps.sns.forms import UploadImageForm, DeleteForm, PostForm, CommentForm, SearchForm, FollowForm
from flask_login import current_user, login_required
from sqlalchemy.exc import SQLAlchemyError
from apps.config import load_tags

# template_folderを指定する（staticは指定しない）
dt = Blueprint("sns", __name__, template_folder="templates")

# load_locations 関数を定義
def load_locations():
    with open(current_app.config['TAG_JSON_PATH'], encoding='utf-8') as f:
        locations_data = json.load(f)
    return locations_data

# dtアプリケーションを使ってエンドポイントを作成する
@dt.route("/")
def index():
    # 投稿一覧を取得（投稿者情報も取得）
    posts = Post.query.order_by(Post.timestamp.desc()).all()
    
    # 検索フォームも渡す
    form = SearchForm()
    return render_template("sns/index.html", posts=posts, form=form)


@dt.route("/images/<path:filename>")
def image_file(filename):
    return send_from_directory(current_app.config["UPLOAD_FOLDER"], filename)

@dt.route("/post", methods=["GET", "POST"])
@login_required
def post():
    form = PostForm()
    
    # 都道府県の選択肢設定
    form.prefecture.choices = [
        (tag_data['id'], tag_data['name']) for data in load_tags() for tag_data in data.values()
    ]
    
    # 市区町村の選択肢設定
    cities = [("", "都道府県を選んでください")]
    for data in load_tags():
        for tag_data in data.values():
            prefecture_name = tag_data['name']
            for city_data in tag_data['city']:
                city_name = city_data['city']
                city_code = city_data['citycode']
                cities.append((city_code, f"{prefecture_name} - {city_name}"))

    # 初期の市区町村選択肢設定
    form.city.choices = cities

    # 都道府県が選択された場合に、その都道府県に関連する市区町村をロード
    if form.prefecture.data:
        selected_prefecture = next((item for item in load_tags() if item.get('id') == form.prefecture.data), None)
        if selected_prefecture:
            cities_for_prefecture = selected_prefecture.get('city', [])
            form.city.choices = [(city["citycode"], city["city"]) for city in cities_for_prefecture]

    # フォームが送信された場合
    if form.validate_on_submit():
        print("フォームが送信されました")
        print("prefecture.data:", form.prefecture.data)
        print("city.data:", form.city.data)

        # 投稿を処理
        post = Post(
            title=form.title.data,
            content=form.content.data,
            user_id=current_user.id,
            prefecture_id=form.prefecture.data,
            city_code=form.city.data,
        )
        db.session.add(post)
        db.session.commit()

        # 画像アップロード処理
        if form.images.data:
            for file in form.images.data:
                ext = Path(file.filename).suffix
                unique_filename = str(uuid.uuid4()) + ext
                upload_path = Path(current_app.config["UPLOAD_FOLDER"], unique_filename)
                file.save(upload_path)

                image = Image(post_image_path=unique_filename, post_id=post.post_id)
                db.session.add(image)
        
        db.session.commit()
        flash("投稿が完了しました")
        return redirect(url_for("sns.index"))
    else:
        print("フォームのバリデーションに失敗しました")
        print(form.errors)  # エラー内容を確認
    
    return render_template("sns/post.html", form=form)


import json
from flask import current_app, request, flash, render_template
from flask_login import login_required

@dt.route("/search", methods=["GET", "POST"])
@login_required
def search():
    form = SearchForm()
    locations_data = load_locations()  # JSONデータを読み込む
    posts = []
    users = []

    if form.validate_on_submit():
        keyword = form.keyword.data.strip() if form.keyword.data else None

        if keyword:
            # 都道府県名や市区町村名を検索
            matching_locations = []
            for location in locations_data:
                for pref_id, pref_data in location.items():
                    # 都道府県名が一致する場合
                    if keyword in pref_data["name"]:
                        matching_locations.append({
                            "id": pref_id,
                            "name": pref_data["name"],
                            "city": None  # 都道府県名だけの場合
                        })

                    # 市区町村名が一致する場合
                    for city in pref_data["city"]:
                        if keyword in city["city"]:
                            matching_locations.append({
                                "id": pref_id,
                                "name": pref_data["name"],
                                "city": city["city"]
                            })

            # 検索結果をデバッグ用に表示
            print("マッチしたロケーション:", matching_locations)

            # マッチしたロケーションに基づいて投稿を検索
            prefecture_ids = [loc['id'] for loc in matching_locations if loc['city'] is None]
            city_codes = [city["citycode"] for loc in matching_locations if loc['city']]

            # 投稿を検索（タイトルや内容、都道府県ID、市区町村コードで検索）
            posts = Post.query.filter(
                (Post.title.contains(keyword)) |
                (Post.content.contains(keyword)) |
                (Post.prefecture_id.in_(prefecture_ids)) |
                (Post.city_code.in_(city_codes))
            ).order_by(Post.timestamp.desc()).all()

            # ユーザーを検索（ユーザー名で検索）
            users = User.query.filter(
                User.username.contains(keyword)
            ).order_by(User.username.asc()).all()

            print(f"投稿の検索結果: {posts}")
            print(f"ユーザーの検索結果: {users}")
        else:
            flash("検索キーワードを入力してください。")
    
    return render_template("sns/index.html", posts=posts, users=users, form=form)





@dt.route("/delete/<string:image_id>", methods=["POST"])
@login_required
def delete(image_id):
    try:
        db.session.query(Image).filter(Image.post_image_id == image_id).delete()  # 修正: `post_image_id`を使用
        db.session.commit()
    except SQLAlchemyError as e:
        flash("画像削除処理でエラーが発生しました")
        current_app.logger.error(e)
        db.session.rollback()

@dt.route("/post/<int:post_id>", methods=["GET", "POST"])
@login_required
def post_detail(post_id):
    post = Post.query.get_or_404(post_id)
    comments = Comment.query.filter_by(post_id=post_id).all()
    form = CommentForm()


    if form.validate_on_submit():
        comment = Comment(content=form.content.data, post_id=post_id, user_id=current_user.id)
        db.session.add(comment)
        db.session.commit()
        flash("コメントを追加しました！")
        return redirect(url_for('sns.post_detail', post_id=post_id))

    return render_template("sns/post_detail.html", post=post, comments=comments, form=form)

@dt.route("/mypage", methods=["GET"])
@login_required
def mypage():
    # ログインしているユーザーの投稿とコメントを取得
    user_posts = Post.query.filter_by(user_id=current_user.id).order_by(Post.timestamp.desc()).all()
    user_comments = Comment.query.filter_by(user_id=current_user.id).order_by(Comment.timestamp.desc()).all()
    
    return render_template("sns/mypage.html", user=current_user, posts=user_posts, comments=user_comments)

@dt.route("/user/<int:user_id>", methods=["GET"])
@login_required
def user_page(user_id):
    # 指定されたユーザーの情報を取得
    user = User.query.get_or_404(user_id)
    user_posts = Post.query.filter_by(user_id=user_id).order_by(Post.timestamp.desc()).all()
    user_comments = Comment.query.filter_by(user_id=user_id).order_by(Comment.timestamp.desc()).all()
    form = FollowForm()
    return render_template("sns/user_page.html", user=user, posts=user_posts, comments=user_comments, form=form)

@dt.route("/user/<int:user_id>/edit_icon", methods=["GET", "POST"])
@login_required
def edit_icon(user_id):
    user = User.query.get_or_404(user_id)

    # ユーザーがログイン中であり、自身の情報のみ編集可能とする
    if user != current_user:
        flash("他のユーザーの情報を編集することはできません。")
        return redirect(url_for("sns.user_page", user_id=user_id))

    form = UploadImageForm()

    if form.validate_on_submit():
        # ユーザー名の更新
        new_username = form.username.data.strip()
        if new_username and len(new_username) <= 50:
            user.username = new_username
        else:
            flash("ユーザー名が無効です。")
            return redirect(url_for("sns.edit_icon", user_id=user_id))

        # 画像ファイルの処理
        if form.image.data:
            file = form.image.data
            ext = Path(file.filename).suffix
            unique_filename = f"user_{user_id}{ext}"
            upload_path = Path(current_app.config["UPLOAD_FOLDER"], unique_filename)
            file.save(upload_path)

            # ユーザーのアイコンを更新
            user.icon_path = unique_filename

        db.session.commit()
        flash("アイコンとユーザー名を更新しました")
        return redirect(url_for("sns.mypage", user_id=user_id))

    # 初期データとして現在のユーザー名をフォームにセット
    form.username.data = user.username
    return render_template("sns/edit_icon.html", form=form, user=user)

@dt.route('/user/<int:user_id>/toggle_follow', methods=['POST'])
@login_required
def toggle_follow(user_id):
    current_user_id = current_user.id
    follow = Follow.query.filter_by(user_id=current_user_id, follow_user_id=user_id).first()

    if not follow:
        # フォローが存在しない場合、新しく追加
        new_follow = Follow(user_id=current_user_id, follow_user_id=user_id)
        db.session.add(new_follow)
    else:
        # フォローが存在する場合、削除
        db.session.delete(follow)

    db.session.commit()
    return redirect(url_for('sns.user_page', user_id=user_id))


@dt.route("/mypage/following", methods=["GET"])
@login_required
def following_list():
    followings = Follow.query.filter_by(user_id=current_user.id).all()
    return render_template("sns/following_list.html", followings=followings)

@dt.route("/mypage/followers", methods=["GET"])
@login_required
def followers_list():
    # 現在のユーザーをフォローしているユーザーを取得
    followers = Follow.query.filter_by(follow_user_id=current_user.id).all()
    followers_users = [User.query.get(follow.user_id) for follow in followers]
    
    return render_template("sns/followers_list.html", followers=followers_users)

@dt.route("/tags/prefectures", methods=["GET"])
def get_prefectures():
    tags = load_tags()
    prefectures = [{"id": p["id"], "name": p["name"]} for p in tags.values()]
    return jsonify(prefectures)

@dt.route("/tags/cities/<pref_id>", methods=["GET"])
def get_cities(pref_id):
    try:
        # load_tags() の戻り値がリスト形式
        tags = load_tags()
        current_app.logger.debug(f"tags: {tags}")  # tagsの内容を確認
        current_app.logger.debug(f"受け取ったpref_id: {pref_id}")  # 受け取ったpref_idを確認

        # リスト内で都道府県IDが一致するものを探す
        prefecture_data = None
        for tag in tags:
            prefecture_data = tag.get(pref_id)
            if prefecture_data:
                break
        
        if not prefecture_data:
            current_app.logger.error(f"都道府県ID {pref_id} が見つかりませんでした。")
            return jsonify({"error": "都道府県データが見つかりません"}), 404
        
        cities = prefecture_data.get("city", [])
        
        if not cities:
            return jsonify({"error": "市区町村データが見つかりません"}), 404
        
        return jsonify(cities)
    
    except Exception as e:
        current_app.logger.error(f"エラーが発生しました: {e}")
        return jsonify({"error": "データの取得に失敗しました"}), 500

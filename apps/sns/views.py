import uuid
from pathlib import Path
from flask import Blueprint, render_template, current_app, send_from_directory, redirect, url_for, flash, request
from apps.app import db
from apps.crud.models import User
from apps.sns.models import Image,Post,Follow,Comment
from apps.sns.forms import UploadImageForm, DeleteForm, PostForm, CommentForm, SearchForm, FollowForm
from flask_login import current_user, login_required
from sqlalchemy.exc import SQLAlchemyError

# template_folderを指定する（staticは指定しない）
dt = Blueprint("sns", __name__, template_folder="templates")

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
    
    if form.validate_on_submit():
        # 投稿を作成
        post = Post(
            title=form.title.data,
            content=form.content.data,
            user_id=current_user.id,
        )
        db.session.add(post)
        db.session.commit()

        # アップロードされた画像を保存
        if form.images.data:
            for file in form.images.data:
                ext = Path(file.filename).suffix
                unique_filename = str(uuid.uuid4()) + ext
                upload_path = Path(current_app.config["UPLOAD_FOLDER"], unique_filename)
                file.save(upload_path)

                # 画像をImageインスタンスとして保存
                image = Image(post_image_path=unique_filename, post_id=post.post_id)
                db.session.add(image)
        
        db.session.commit()
        flash("投稿が完了しました")
        return redirect(url_for("sns.index"))  # 投稿リストにリダイレクト

    # GETメソッドまたはフォームのバリデーション失敗時にフォームを再表示
    return render_template("sns/post.html", form=form)


@dt.route("/search", methods=["GET", "POST"])
@login_required
def search():
    form = SearchForm()
    posts = []
    users = []

    # デバッグ情報を表示
    print(f"リクエストメソッド: {request.method}")
    print(f"フォームの入力データ: {form.keyword.data}")

    if form.validate_on_submit():
        print("フォームがバリデーションを通過しました")
        keyword = form.keyword.data.strip() if form.keyword.data else None

        if keyword:
            print(f"検索キーワード: {keyword}")

            # 投稿を検索
            posts = Post.query.filter(
                (Post.title.contains(keyword)) | (Post.content.contains(keyword))
            ).order_by(Post.timestamp.desc()).all()
            print(f"投稿の検索結果: {posts}")

            # ユーザーを検索
            users = User.query.filter(
                User.username.contains(keyword)
            ).order_by(User.username.asc()).all()
            print(f"ユーザーの検索結果: {users}")
        else:
            flash("検索キーワードを入力してください。")
    else:
        flash("フォームの入力にエラーがあります。")
        print("フォームのエラー:", form.errors)

    # テンプレートへのデータ渡し
    return render_template(
        "sns/index.html", 
        posts=posts, 
        users=users, 
        form=form
    )


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


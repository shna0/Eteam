import uuid
from pathlib import Path
from flask import Blueprint, render_template, current_app, send_from_directory, redirect, url_for, flash, request
from apps.app import db
from apps.crud.models import User
from apps.sns.models import Image,Post,Follow,Comment
from apps.sns.forms import UploadImageForm, DeleteForm, PostForm, CommentForm
from flask_login import current_user, login_required
from sqlalchemy.exc import SQLAlchemyError

# template_folderを指定する（staticは指定しない）
dt = Blueprint("sns", __name__, template_folder="templates")

# dtアプリケーションを使ってエンドポイントを作成する
@dt.route("/")
def index():
    # 投稿一覧を取得（投稿者情報も取得）
    posts = Post.query.order_by(Post.timestamp.desc()).all()
    return render_template("sns/index.html", posts=posts)


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
            user_id=current_user.user_id,
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


@dt.route("/search", methods=["GET"])
def search():
    search_query = request.args.get("search", "")
    # 検索処理をここに記述
    return render_template("sns/search_results.html", search_query=search_query)


@dt.route("/images/delete/<string:image_id>", methods=["POST"])
@login_required
def delete_image(image_id):
    try:
        db.session.query(Image).filter(Image.post_image_id == image_id).delete()  # 修正: `post_image_id`を使用
        db.session.commit()
    except SQLAlchemyError as e:
        flash("画像削除処理でエラーが発生しました")
        current_app.logger.error(e)
        db.session.rollback()

@dt.route("/post/<int:post_id>", methods=["GET", "POST"])
def post_detail(post_id):
    post = Post.query.get_or_404(post_id)
    comments = Comment.query.filter_by(post_id=post_id).all()
    form = CommentForm()

    if form.validate_on_submit():
        comment = Comment(content=form.content.data, post_id=post_id, user_id=current_user.user_id)
        db.session.add(comment)
        db.session.commit()
        flash("コメントを追加しました！")
        return redirect(url_for('sns.post_detail', post_id=post_id))

    return render_template("sns/post_detail.html", post=post, comments=comments, form=form)

import uuid
from pathlib import Path
from flask import Blueprint, render_template, current_app, send_from_directory, redirect, url_for, flash, request
from apps.app import db
from apps.crud.models import User
from apps.sns.models import Image,Post,Follow,Comment
from apps.sns.forms import UploadImageForm, DeleteForm, PostForm
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
        # 投稿内容を保存
        new_post = Post(
            title=form.title.data,
            content=form.content.data,
            user_id=current_user.user_id,  # 現在ログイン中のユーザー
        )
        db.session.add(new_post)
        db.session.commit()
        flash("投稿が完了しました！", "success")
        return redirect(url_for("sns.index"))

    return render_template("sns/post.html", form=form)

@dt.route("/upload", methods=["GET", "POST"])
@login_required
def upload_image():
    form = UploadImageForm()
    # フォームの投稿選択肢に投稿データを渡す
    form.post_id.choices = [(post.post_id, post.title) for post in Post.query.all()]

    if form.validate_on_submit():
        file = form.image.data
        ext = Path(file.filename).suffix
        image_uuid_file_name = str(uuid.uuid4()) + ext

        image_path = Path(current_app.config["UPLOAD_FOLDER"], image_uuid_file_name)
        file.save(image_path)

        # 投稿に関連付けて画像を保存
        user_image = Image(
            post_id=form.post_id.data, post_image_path=image_uuid_file_name
        )
        db.session.add(user_image)
        db.session.commit()

        return redirect(url_for("detector.index"))
    return render_template("detector/upload.html", form=form)

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

   

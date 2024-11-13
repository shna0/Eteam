import uuid
from pathlib import Path
from flask import Blueprint, render_template, current_app, send_from_directory, redirect, url_for, flash, request
from apps.app import db
from apps.crud.models import User
from apps.sns.models import UserImage
from apps.sns.forms import UploadImageForm, DeleteForm
from flask_login import current_user, login_required
from sqlalchemy.exc import SQLAlchemyError

# template_folderを指定する（staticは指定しない）
dt = Blueprint("detector", __name__, template_folder="templates")

# dtアプリケーションを使ってエンドポイントを作成する
@dt.route("/")
def index():
    # UserとUserImageをjoinして画像一覧を取得する
    user_images = (
        db.session.query(User, UserImage)
        .join(UserImage)
        .filter(User.id == UserImage.user_id)
        .all()
    )

    delete_form = DeleteForm()

    return render_template(
        "detector/index.html",
        user_images=user_images,
        delete_form=delete_form,
    )

@dt.route("/images/<path:filename>")
def image_file(filename):
    return send_from_directory(current_app.config["UPLOAD_FOLDER"], filename)

@dt.route("/upload", methods=["GET", "POST"])
@login_required
def upload_image():
    form = UploadImageForm()
    if form.validate_on_submit():
        file = form.image.data
        ext = Path(file.filename).suffix
        image_uuid_file_name = str(uuid.uuid4()) + ext

        image_path = Path(
            current_app.config["UPLOAD_FOLDER"], image_uuid_file_name
        )
        file.save(image_path)

        user_image = UserImage(
            user_id=current_user.id, image_path=image_uuid_file_name
        )
        db.session.add(user_image)
        db.session.commit()

        return redirect(url_for("detector.index"))
    return render_template("detector/upload.html", form=form)

@dt.route("/images/delete/<string:image_id>", methods=["POST"])
@login_required
def delete_image(image_id):
    try:
        db.session.query(UserImageTag).filter(
            UserImageTag.user_image_id == image_id
        ).delete()
        db.session.query(UserImage).filter(UserImage.id == image_id).delete()
        db.session.commit()
    except SQLAlchemyError as e:
        flash("画像削除処理でエラーが発生しました")
        current_app.logger.error(e)
        db.session.rollback()

    return redirect(url_for("detector.index"))

@dt.route("/images/search", methods=["GET"])
def search():
    user_images = db.session.query(User, UserImage).join(
        UserImage, User.id == UserImage.user_id
    )

    search_text = request.args.get("search")
    user_image_tag_dict = {}
    filtered_user_images = []

    for user_image in user_images:
        if not search_text:
            user_image_tags = (
                db.session.query(UserImageTag)
                .filter(UserImageTag.user_image_id == user_image.UserImage.id)
                .all()
            )
        else:
            user_image_tags = (
                db.session.query(UserImageTag)
                .filter(UserImageTag.user_image_id == user_image.UserImage.id)
                .filter(UserImageTag.tag_name.like(f"%{search_text}%"))
                .all()
            )

            if not user_image_tags:
                continue

        user_image_tag_dict[user_image.UserImage.id] = user_image_tags
        filtered_user_images.append(user_image)

    delete_form = DeleteForm()

    return render_template(
        "detector/index.html",
        user_images=filtered_user_images,
        user_image_tag_dict=user_image_tag_dict,
        delete_form=delete_form,
    )

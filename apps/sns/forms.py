from flask_wtf.file import FileAllowed, FileRequired
from flask_wtf.form import FlaskForm
from wtforms import FileField, SubmitField, SelectField
from wtforms.validators import DataRequired

from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField, SubmitField,MultipleFileField
from wtforms.validators import DataRequired, Length

class PostForm(FlaskForm):
    title = StringField("タイトル", validators=[DataRequired()])
    content = TextAreaField("内容", validators=[DataRequired()])
    images = MultipleFileField("画像", validators=[FileAllowed(['jpg', 'png', 'gif'], "画像ファイルのみアップロード可能です")])
    submit = SubmitField("投稿")


class UploadImageForm(FlaskForm):
    # ファイルフィールドに必要なバリデーションを設定する
    image = FileField(
        validators=[
            FileRequired("画像ファイルを指定してください。"),
            FileAllowed(["png", "jpg", "jpeg"], "サポートされていない画像形式です。"),
        ]
    )
    post_id = SelectField("投稿", coerce=int, validators=[DataRequired()])
    submit = SubmitField("アップロード")


class DetectorForm(FlaskForm):
    submit = SubmitField("検知")


class DeleteForm(FlaskForm):
    submit = SubmitField("削除")
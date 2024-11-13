from flask_wtf.file import FileAllowed, FileRequired
from flask_wtf.form import FlaskForm
from wtforms import FileField, SubmitField, SelectField
from wtforms.validators import DataRequired



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
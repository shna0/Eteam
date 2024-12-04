# 中保秀真
import json
from pathlib import Path
from flask import current_app

basedir = Path(__file__).parent.parent


# BaseConfigクラスを作成する
class BaseConfig:
    SECRET_KEY = "2AZSMss3p5QPbcY2hBsJ"
    WTF_CSRF_SECRET_KEY = "AuwzyszU5sugKN7KZs6f"
    UPLOAD_FOLDER = str(Path(__file__).parent.parent / "apps" / "images")
    TAG_JSON_PATH = basedir / "apps" / "data" / "japan_tags.json"


# BaseConfigクラスを継承してLocalConfigクラスを作成する
class LocalConfig(BaseConfig):
    SQLALCHEMY_DATABASE_URI = f"postgresql://postgres:oohara2024e@localhost/flask_sns"
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_ECHO = True


# BaseConfigクラスを継承してTestingConfigクラスを作成する
class TestingConfig(BaseConfig):
    SQLALCHEMY_DATABASE_URI = f"postgresql://postgres:oohara2024e@localhost/flask_sns"
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    WTF_CSRF_ENABLED = False

def load_tags():
    with open(current_app.config['TAG_JSON_PATH'], encoding='utf-8') as file:
        return json.load(file)

# config辞書にマッピングする
config = {
    "testing": TestingConfig,
    "local": LocalConfig,
}

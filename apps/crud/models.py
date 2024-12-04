# 中保秀真
from apps.app import db, login_manager
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash

from apps.sns.models import Follow

class User(db.Model, UserMixin):
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, index=True)
    email = db.Column(db.String, unique=True, index=True)
    password_hash = db.Column(db.String)
    icon_path = db.Column(db.String, default="default_icon.png")

    posts = db.relationship("Post", back_populates="user")

    @property
    def password(self):
        raise AttributeError("読み取り不可")
    
    @password.setter
    def password(self,password):
        self.password_hash = generate_password_hash(password)

    def verify_password(self, password):
        return check_password_hash(self.password_hash,password)
    
    def is_duplicate_email(self):
        return User.query.filter_by(email=self.email).first() is not None
    
    def get_id(self):
        return str(self.id)  # user_idを返すようにする
    
    # crud/models.py
    @property
    def is_followed_by_current_user(self):
        from flask_login import current_user
        return Follow.query.filter_by(user_id=current_user.id, follow_user_id=self.id).first() is not None

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(user_id)
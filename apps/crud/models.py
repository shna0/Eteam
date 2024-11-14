from apps.app import db, login_manager
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash


class User(db.Model, UserMixin):
    __tablename__ = "user"

    user_id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, index=True)
    email = db.Column(db.String, unique=True, index=True)
    password_hash = db.Column(db.String)

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
        return str(self.user_id)  # user_idを返すようにする

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(user_id)
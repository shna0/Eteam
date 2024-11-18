from datetime import datetime

from apps.app import db

class Post(db.Model):
    __tablename__ = "post"
    post_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String)
    content = db.Column(db.String)
    timestamp = db.Column(db.DateTime, default=datetime.now)
    user_id = db.Column(db.Integer, db.ForeignKey("user.user_id"), nullable=False)
    user = db.relationship("User", back_populates="posts")
    # Post が所有する画像
    images = db.relationship("Image", back_populates="post", cascade="all, delete-orphan")


class Image(db.Model):
    __tablename__ = "images"
    post_image_id = db.Column(db.Integer, primary_key=True)
    post_image_path = db.Column(db.String)
    # 投稿に関連付け
    post_id = db.Column(db.Integer, db.ForeignKey("post.post_id"), nullable=False)
    post = db.relationship("Post", back_populates="images")

class Follow(db.Model):
    __tablename__ = "follow"
    user_id = db.Column(db.Integer, db.ForeignKey("user.user_id"), primary_key=True)
    follow_user_id = db.Column(db.Integer, db.ForeignKey("user.user_id"), primary_key=True)
    follow_date = db.Column(db.DateTime, default=datetime.now)

class Comment(db.Model):
    __tablename__ = "comment"
    comment_id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.String)
    timestamp = db.Column(db.DateTime, default=datetime.now)
    user_id = db.Column(db.Integer, db.ForeignKey("user.user_id"))
    post_id = db.Column(db.Integer, db.ForeignKey("post.post_id"))
    user = db.relationship('User', backref='comments')


class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, class_name: 'Comment', foreign_key: 'post_id'
  has_many :likes, class_name: 'Like', foreign_key: 'post_id'

  after_save :update_posts_counter

  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }

  def increment_posts_counter
    author.increment!(:posts_counter)
  end

  def recent_comment_counter
    comments.order(created_at: :desc).limit(5)
  end
end

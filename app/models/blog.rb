class Blog < ApplicationRecord
  belongs_to :user
  has_many :blogcomments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :image

  validates :title, presence: true
  validates :category, presence: true
  validates :body, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end

class Blog < ApplicationRecord
  belongs_to :user
  has_many :blogcomments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :image

  def favorited_by?(user)
    favorites.where(user_id: user_id).exists?
  end

end

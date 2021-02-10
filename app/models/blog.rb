class Blog < ApplicationRecord
  belongs_to :user
  has_many :blogcomments, dependent: :destroy
  attachment :image
end

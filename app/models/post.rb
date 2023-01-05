class Post < ApplicationRecord

  attachment :image

  belongs_to :user
  has_many :comments, dependent: :destroy  #この行を追記

  has_many :favorites, dependent: :destroy
  validates :location, presence: true, length: { maximum: 15 }
  validates :text, presence: true, length: { maximum: 100 }
  validates :image, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end


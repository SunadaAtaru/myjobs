class Post < ApplicationRecord

  attachment :image

  belongs_to :user
  has_many :comments, dependent: :destroy  #この行を追記

  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end


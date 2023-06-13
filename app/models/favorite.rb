class Favorite < ApplicationRecord
  

  belongs_to :user
  belongs_to :post   #post_imageモデルから書き換え

  # validates :comment, presence: true, length: { maximum: 35 }

end

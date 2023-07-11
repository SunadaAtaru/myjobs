class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  enum reaction_type: { like: 0, thanks: 1, awesome: 2 }

  # validates :reaction_type, inclusion: { in: reaction_types.keys }
  # validates :reaction_type, presence: true, inclusion: { in: %w(like thanks awesome) }
  # validates_uniqueness_of :reaction_type, scope: [:user_id, :post_id] 
  validates :reaction_type, inclusion: { in: reaction_types.keys } # enumのバリデーション
  validates :user_id, uniqueness: { scope: [:post_id, :reaction_type] } # 1ユーザーが1投稿に対して1種類のリアクションしかできないようにする
end

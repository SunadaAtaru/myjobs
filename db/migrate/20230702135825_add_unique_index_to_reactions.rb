class AddUniqueIndexToReactions < ActiveRecord::Migration[5.2]
  def change
    add_index :reactions, [:user_id, :post_id, :reaction_type], unique: true
  end
end

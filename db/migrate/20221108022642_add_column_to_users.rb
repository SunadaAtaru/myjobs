class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    # 以下を追加
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    
  end
end

class AddNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :optional_id, :string, unique: true
    add_column :users, :nickname, :string
    add_column :users, :profile_image_id, :string
    add_column :users, :is_valid,:boolean, default: true, null: false
  end
end

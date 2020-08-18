class AddNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string
    add_column :users, :birth_date, :date
    add_column :users, :height, :integer
    add_column :users, :sex, :integer
    add_column :users, :profile_image_id, :string
    add_column :users, :is_valid,:boolean, default: true, null: false
  end
end

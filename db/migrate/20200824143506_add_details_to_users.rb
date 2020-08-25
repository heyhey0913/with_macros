class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change

  	# User infomation
    add_column :users, :optional_id, :string, unique: true
    add_column :users, :nickname, :string
    add_column :users, :profile_image_id, :string
    add_column :users, :is_valid,:boolean, default: true, null: false

  	# Goal setting
	add_column :users, :target_weight, :float
	add_column :users, :current_weight, :float
	add_column :users, :current_body_fat, :float
	add_column :users, :active_factor, :float
	add_column :users, :weekly_target_weight, :float
	add_column :users, :dairy_target_calorie, :float
	add_column :users, :protein_intake_ratio, :float
	add_column :users, :fat_intake_ratio, :float
	add_column :users, :carbohydrate_intake_ratio, :float
  end
end

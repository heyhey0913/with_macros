class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
    	t.references :user
    	t.float :initial_weight
    	t.float :target_weight
    	t.float :current_weight
    	t.float :active_factor
    	t.integer :body_fat
      t.float :weekly_target_weight
      t.integer :dairy_target_calorie
    	t.integer :protein_intake_ratio
      t.integer :fat_intake_ratio
      t.integer :carbohydrate_intake_ratio

      t.timestamps
    end
  end
end

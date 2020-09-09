class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|

      t.references  :user
      t.string      :dish_name
      t.text        :method
      t.string      :dish_image_id
      t.float       :total_calorie
      t.float       :protein_ratio
      t.float       :fat_ratio
      t.float       :carbohydrate_ratio
      t.float       :protein_content
      t.float       :fat_content
      t.float       :carbohydrate_content
      t.integer     :creation_status, default: 0, null: false
      t.boolean     :is_published, default: false, null: false

      t.timestamps
    end
  end
end

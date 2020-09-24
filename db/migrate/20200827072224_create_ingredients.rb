class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|

      t.string      :name, unique: true
      t.float       :total_calorie
      t.float       :protein_ratio
      t.float       :fat_ratio
      t.float       :carbohydrate_ratio
      t.float       :protein_content
      t.float       :fat_content
      t.float       :carbohydrate_content

      t.timestamps
    end
  end
end

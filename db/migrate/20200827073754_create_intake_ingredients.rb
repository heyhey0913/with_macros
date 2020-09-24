class CreateIntakeIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :intake_ingredients, id: :bigint do |t|

      t.references  :intake_date
      t.references  :ingredient
      t.float       :weight

      t.timestamps
    end
  end
end

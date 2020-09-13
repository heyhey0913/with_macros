class CreateIntakeIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :intake_ingredients, id: :bigint do |t|

      t.references  :user
      t.references  :ingredient
      t.float       :weight
      t.date        :recorded_on

      t.timestamps
    end
  end
end

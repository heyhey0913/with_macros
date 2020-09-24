class CreateIntakeRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :intake_recipes, id: :bigint do |t|

      t.references  :intake_date
      t.references  :recipe
      t.float       :number

      t.timestamps
    end
  end
end

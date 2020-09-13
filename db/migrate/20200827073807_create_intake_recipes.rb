class CreateIntakeRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :intake_recipes, id: :bigint do |t|

      t.references  :user
      t.references  :recipe
      t.float       :number
      t.date        :recorded_on

      t.timestamps
    end
  end
end

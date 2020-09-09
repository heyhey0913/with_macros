class CreateIntakeRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :intake_recipes, id: :bigint do |t|

      t.references  :intake_log
      t.references  :recipe
      t.float       :weight

      t.timestamps
    end
  end
end

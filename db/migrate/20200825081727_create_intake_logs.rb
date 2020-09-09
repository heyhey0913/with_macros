class CreateIntakeLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :intake_logs do |t|

	  t.references :user
      t.float   :total_calorie
      t.float   :total_protein
      t.float   :total_fat
      t.float   :total_carbohydrate

      t.timestamps
    end
  end
end

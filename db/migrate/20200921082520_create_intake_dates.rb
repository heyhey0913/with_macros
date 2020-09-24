class CreateIntakeDates < ActiveRecord::Migration[5.2]
  def change
    create_table :intake_dates, id: :bigint do |t|

      t.references  :user
      t.date        :recorded_on

      t.timestamps
    end
  end
end

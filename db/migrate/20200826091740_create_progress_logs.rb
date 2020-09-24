class CreateProgressLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :progress_logs do |t|

      t.references :user
      t.float   :weight
      t.float   :body_fat
      t.string   :body_image_id
      t.date   :recorded_on

      t.timestamps
    end
  end
end

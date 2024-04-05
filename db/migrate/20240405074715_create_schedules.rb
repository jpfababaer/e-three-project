class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.string :day_of_week, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.integer :duration, default: 60
      t.references :trainer, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end

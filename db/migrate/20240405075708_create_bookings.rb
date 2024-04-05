class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.datetime :started_at, null: false
      t.datetime :ended_at, null: false
      t.references :client, null: false, foreign_key: { to_table: :users}
      t.references :trainer, null: false, foreign_key: { to_table: :users}

      t.timestamps
    end
  end
end

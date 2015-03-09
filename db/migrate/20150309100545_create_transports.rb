class CreateTransports < ActiveRecord::Migration
  def change
    create_table :transports do |t|
      t.float :distance
      t.text :duration
      t.text :departure_time
      t.text :departure_place
      t.text :arrival_time
      t.text :arrival_place
      t.integer :transfers

      t.timestamps null: false
    end
  end
end

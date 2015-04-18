class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.text :departureStop
      t.text :arrivalStop
      t.text :departureTime
      t.text :arrivalTime
      t.text :lineName
      t.text :travelTime
      t.integer :travelType
      t.belongs_to :trip, index: true

      t.timestamps null: false
    end
  end
end

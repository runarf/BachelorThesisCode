class AddLatitudeAndLongitudeToTransport < ActiveRecord::Migration
  def change
    add_column :transports, :latitude, :float
    add_column :transports, :longitude, :float
  end
end

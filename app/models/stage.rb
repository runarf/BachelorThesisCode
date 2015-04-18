class Stage < ActiveRecord::Base
  enum travelType: [:walking, :airportBus, :bus, :dummy, :airportTrain, :boat, :train, :tram, :metro]
  belongs_to :trip
end

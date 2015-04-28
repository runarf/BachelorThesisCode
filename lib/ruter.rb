require "benchmark"

class Ruter
  include HTTParty

  base_uri 'reisapi.ruter.no'

  def self.getRoute(from, to)
    response = nil
    time = Benchmark.realtime do
      response = get('/Travel/GetTravels/', query: {
                                              fromplace: from,
                                              toplace: to,
                                              isAfter: true,
                                          })
    end
    puts "Time elapsed #{time*1000} milliseconds"
    return response
  end

  def self.getPlaceWithName(place)

    get('/Place/GetPlaces/', query: {
                               id: place,
                               counties: "Oslo"
                           })
  end

  def self.getStops
    get('/place/getstopsruter')
  end

  def self.getHeartbeat
    get('/Heartbeat/index')
  end
end
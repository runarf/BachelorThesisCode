class Ruter
  include HTTParty

  base_uri 'reisapi.ruter.no'

  def self.getRoute(from, to)
    response = get('/Travel/GetTravels/', query: {
                                            fromplace: from,
                                            toplace: to,
                                            isAfter: true,
                                        })
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
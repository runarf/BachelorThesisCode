class Ruter
  include HTTParty

  base_uri 'reisapi.ruter.no'
  #base_uri 'api.trafikanten.no'

  def self.getRoute(from, to)
    response = get('/Travel/GetTravels/', query: {
                                            #time: "050320150720",
                                            fromplace: from,
                                            toplace: to,
                                            isAfter: true,
                                            #transporttypes: "Bus"
                                        })

    #pp response["TravelProposals"][0]["Stages"]

    #get('/Travel/GetTravelsByPlaces/?time=010120130729&toplace=(x=600000,y=6642000)&fromplace=2190400&changeMargin=2&changePunish=10&walkingFactor=100&walkingDistance=2000&isAfter=True&proposals=12&transporttypes=Bus,AirportTrain,Boat,Train,Tram,Metro')
  end

  def self.getPlaceWithName(place)

    get('/Place/GetPlaces/', query: {
                               id: place,
                               counties: "Oslo"
                           })
  end

  def self.getStops
    get('/place/getstopsruter')
    #get('/Place/GetStop/2190400')
  end

  def self.getHeartbeat
    get('/Heartbeat/index')
  end
end
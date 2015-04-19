class TripsController < ApplicationController

  def index

  end

  def to_minute(input)
    input = DateTime.parse(input)
    hours = input.strftime("%H").to_i
    minutes = input.strftime("%M").to_i
    hours * 60 + minutes
  end

  def to_hour_minute(time)
    time = DateTime.parse(time)
    time = time.strftime("%H:%M")
  end

  def time_difference(time)
    diff_seconds = (time.to_time - Time.now.round).round
    diff_minutes = diff_seconds / 60
  end


  def create
    @trip = Trip.new

    # Get start coordinates
    latLon = Geocoder.coordinates params[:from]
    utm = GeoUtm::LatLon.new latLon[0], latLon[1]
    utm = utm.to_utm
    east = utm.e.to_i.to_s
    north = utm.n.to_i.to_s
    from_coord = "(x=" + east + ",y=" + north + ")"

    # Get end coordinate
    latLon = Geocoder.coordinates params[:to]
    utm = GeoUtm::LatLon.new latLon[0], latLon[1]
    utm = utm.to_utm
    east = utm.e.to_i.to_s
    north = utm.n.to_i.to_s
    to_coord = "(x=" + east + ",y=" + north + ")"

    # Get the route
    trip = Ruter.getRoute(from_coord, to_coord)

    # Get trip
    trip = trip["TravelProposals"][0]

    # Get stages
    stages = trip["Stages"]
    #puts trip.as_json.to_json
    stages.each do |currStage|
      stage = @trip.stages.build
      stage.travelType = currStage["Transportation"]
      time = "WalkingTime"

      if (stage["travelType"] != Stage.travelTypes[:walking] and
          stage["travelType"] != Stage.travelTypes[:dummy])
        stage.departureStop = currStage["DepartureStop"]["Name"]
        stage.arrivalStop = currStage["ArrivalStop"]["Name"]
        stage.lineName = currStage["LineName"]
        time = "TravelTime"
      end

      stage.travelTime = currStage[time]
      stage.departureTime = currStage["DepartureTime"]
      stage.arrivalTime = currStage["ArrivalTime"]
    end

    # Find time from now until the bus goes
    @trip.departure_time = to_hour_minute(trip["DepartureTime"])
    @trip.arrival_time = to_hour_minute(trip["ArrivalTime"])
    time_diff = time_difference(trip["DepartureTime"].to_time)
    @trip.duration = to_minute(trip["TotalTravelTime"]) + time_diff

    # Fill model
    @trip.departure_place = params[:from]
    @trip.arrival_place = params[:to]
    @trip.transfers = stages.length

    @trip.save

    respond_to do |format|
      format.js {""}
    end

  end


end



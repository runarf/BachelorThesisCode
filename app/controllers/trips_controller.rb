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

    trip = nil
    i = 0
    # Get the route
    while trip == nil && i < 100 do
      trip = Ruter.getRoute(from_coord, to_coord)
      i += 1
    end


    # Get trip
    trip = trip["TravelProposals"][0]


    # Get stages
    changes = trip["Stages"].length
    #puts trip.as_json.to_json

    # Find time from now until the bus goes
    @trip.departure_time = to_hour_minute(trip["DepartureTime"])
    @trip.arrival_time = to_hour_minute(trip["ArrivalTime"])
    time_diff = time_difference(trip["DepartureTime"].to_time)
    @trip.duration = to_minute(trip["TotalTravelTime"]) + time_diff

    # Fill model
    @trip.departure_place = params[:from]
    @trip.arrival_place = params[:to]
    @trip.transfers = changes
    respond_to do |format|
      format.js { }
    end

  end


end



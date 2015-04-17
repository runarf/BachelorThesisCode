class TransportsController < ApplicationController

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
    @trip = Transport.new
    byebug
    
    departure = params[:from].split(',')
    departure = Ruter.getPlaceWithName(departure[0])
    departure_place = departure[0]["ID"]

    arrival = params[:to].split(',')
    arrival = Ruter.getPlaceWithName(arrival[0])
    arrival_place = arrival[0]["ID"]

    trip = Ruter.getRoute(departure_place, arrival_place)
    trip = trip["TravelProposals"][0]
    @trip.transfers = trip["Stages"].length
    @trip.departure_place = params[:from]
    @trip.departure_time = to_hour_minute(trip["DepartureTime"])
    @trip.arrival_place = params[:to]
    @trip.arrival_time = to_hour_minute(trip["ArrivalTime"])
    time_diff = time_difference(trip["DepartureTime"].to_time)
    @trip.duration = to_minute(trip["TotalTravelTime"]) + time_diff

    respond_to do |format|
      format.js { }
    end

  end


end



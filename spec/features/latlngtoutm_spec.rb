require 'rails_helper'

RSpec.feature 'Lat Lng to Utm' do
  before do
    @osloLat = 59.913869
    @osloLon = 10.752245
    @osloEast = 597982.51
    @osloNorth = 6643115.61
    @osloZone = "32V"
    @latLon = Geocoder.coordinates("Oslo")
  end

  scenario 'Latitude and longitude are correct' do
    expect(@latLon[0]).to be_within(0.1).of(@osloLat)
    expect(@latLon[1]).to be_within(0.1).of(@osloLon)
  end

  scenario 'Utm conversion is correct' do
    utm = GeoUtm::LatLon.new @latLon[0], @latLon[1]
    utm = utm.to_utm

    expect(utm.e).to be_within(0.1).of(@osloEast)
    expect(utm.n).to be_within(0.1).of(@osloNorth)
    expect(utm.zone).to eql(@osloZone)
  end
end
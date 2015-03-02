/*
function initialize() {
    var mapOptions = {
	center: { lat: -34.397, lng: 150.644 },
	zoom: 8
    };
    var map = new google.maps.Map(document.getElementById("map-canvas"),
				  mapOptions);
}

google.maps.event.addDomListener(window, 'load', initialize);
*/
/*
var map;
var geocoder;
var bounds = new google.maps.LanLngBounds();
var markersArray = [];

var origin;
var destination;

function initialize() {
    var service = new google.maps.DistanceMatrixService();
    service.getDistanceMatrix(
	{
	    origins: [origin],
	    destinations: [destination],
	    travelMode: google.maps.TravelMode.DRIVING,
	    unitSystem: google.maps.UnitSystem.METRIC,
	    avoidHighways: false,
	    avoidTolls: false
	}, callback);
}*/

$(document).ready(function() {
    $("button").click(function () {
	origin = $("#from").val();
	destination = $("#to").val();
	$("#randomshit").append(origin);
	$("#randomshit").append(destination);
    });
});
		   

function initialize(origin, destination) {
    var service = new google.maps.DistanceMatrixService();

    // Setup options
    var optionsWalk = {
        origins: [origin],
        destinations: [destination],
        unitSystem: google.maps.UnitSystem.METRIC,
        travelMode: google.maps.TravelMode.WALKING,
        avoidHighways: false,
        avoidTolls: false
    };

    var optionsCycle = $.extend(true, {}, optionsWalk);
    var optionsDrive = $.extend(true, {}, optionsWalk);
    //var optionsCommute = $.extend(true, {}, optionsWalk);
    optionsCycle.travelMode = google.maps.TravelMode.BICYCLING;
    optionsDrive.travelMode = google.maps.TravelMode.DRIVING;
    //optionsCommute.travelMode = google.maps.TravelMode.TRANSIT;

    // Get distances
    /*if ($("#public_transport").is(":checked")) {
        service.getDistanceMatrix(optionsCommute, commuteCallback);
    }*/
    if ($("#walking").is(":checked")) {
        console.time("Distance");
        console.timeStamp("Measuring time");
        service.getDistanceMatrix(optionsWalk, walkCallback);
        console.timeEnd("Distance");
    }
    if ($("#cycling").is(":checked")) {
        service.getDistanceMatrix(optionsCycle, cycleCallback);
    }
    if ($("#driving").is(":checked")) {
        service.getDistanceMatrix(optionsDrive, driveCallback);
    }
}

function commuteCallback(response, status) {
    callback(response, status, "commute");
}

function driveCallback(response, status) {
    callback(response, status, "drive");
}

function walkCallback(response, status) {
    callback(response, status, "walk");
}

function cycleCallback(response, status) {
    callback(response, status, "cycle");
}

function callback(response, status, transportation) {
    console.log("Response status is %s", status);
    console.log("Transportation type is %s", transportation);

    if (status != google.maps.DistanceMatrixStatus.OK) {
        alert('Error was: ' + status);
    } else {

        var origins = response.originAddresses;
        var destinations = response.destinationAddresses;

        // Decide type of transportation
        var output;
        var transportType = "Walking";
        var dirflg = "w";
        if (transportation == "walk") {
            output = document.getElementById('outputWalking');
        } else if (transportation == "drive") {
            output = document.getElementById('outputDriving');
            transportType = "Driving";
            dirflg = "c";
        } else if (transportation == "commute") {
            output = document.getElementById('outputBus');
            transportType = "Commute";
            dirflg = "r";
        }
        else {
            output = document.getElementById('outputCycling');
            transportType = "Cycling";
            dirflg = "b";
        }

        var results = response.rows[0].elements;
        var result = results[0];

        // Calculate arrival time
        var currentDate = new Date();
        var duration = Math.round(result.duration.value / 60);
        var arrivalTime = (currentDate.getMinutes() + duration);
        var arrivalMinute = arrivalTime % 60;
        var arrivalHour = currentDate.getHours() + Math.floor(arrivalTime / 60);

        // Create link to directions
        var gUrl = "http://maps.google.com/maps?saddr=" + origins + "&daddr=" + destinations + "&dirflg=" + dirflg;
        gUrl = encodeURI(gUrl);
        var directions = '<a href=' + gUrl + '> Directions </a>';

        // Output to html
        output.innerHTML += '<h1>' + transportType + ':</h1>' + result.duration.text +
        ' and you\'ll arrive ' + arrivalHour + ":" + arrivalMinute + '' +
        directions + '<br><br>';
    }
}

function displayWeather(data) {
    var symbolVal = parseInt(data.query.results.location.symbol.number);
    if (symbolVal < 10) {
        symbolVal = ('0' + symbolVal).slice(-2);
    }
    var url = "http://symbol.yr.no/grafikk/sym/b100/" + symbolVal + "d.png";
    var image = $("<img />").attr('src', url);
    $("#weather").append(image);
}


function getWeather(from) {
    console.log("From is" + from.getPlace());
    var baseUrl = "http://query.yahooapis.com/v1/public/yql?q=";
    var select = "select * from xml where url=";
    var weatherUrl = "'http://api.met.no/weatherapi/locationforecast/1.9/?";
    var where = " and itemPath='/weatherdata/product/time[1]/location/temperature | " +
        "/weatherdata/product/time[2]/location'";
    var format = "&format=json&callback=?";
    var place = from.getPlace();

    // Only need two decimals
    var lat = place.geometry.location.k.toString().match(/^\d+(?:\.\d{0,2})?/);
    var lon = place.geometry.location.D.toString().match(/^\d+(?:\.\d{0,2})?/);

    weatherYQL = baseUrl + select + weatherUrl + "lat=" + lat + ";lon=" + lon + "'" + where + format;
    weatherYQL = encodeURI(weatherYQL);
    console.time("Weather");
    $.getJSON(weatherYQL, displayWeather);
    console.timeEnd("Weather");
}

$(document).ready(function () {
    console.log("Starting javascript");
    var options = {
        componentRestrictions: {country: 'no'}
    };
    var from = new google.maps.places.Autocomplete(
        document.getElementById('from'), options
    );
    var to = new google.maps.places.Autocomplete(
        document.getElementById('to'), options
    );
    $(".form_submit").click(function () {
        $("#outputBus").empty();
        $("#outputWalking").empty();
        $("#outputCycling").empty();
        $("#outputDriving").empty();
        $("#weather").empty();
        var origin = $("#from").val();
        var destination = $("#to").val();
        initialize(origin, destination);
        getWeather(from);
    });
});
		   

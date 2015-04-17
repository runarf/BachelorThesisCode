function initialize(origin, destination) {
    var service = new google.maps.DistanceMatrixService();
    service.getDistanceMatrix(
        {
            origins: [origin],
            destinations: [destination],
            travelMode: google.maps.TravelMode.WALKING,
            unitSystem: google.maps.UnitSystem.METRIC,
            avoidHighways: false,
            avoidTolls: false
        }, callback);
}

function callback(response, status) {
    console.log("Response status is %s", status);
    console.log("Response is %s", response);
    console.log("Response origin is %s", response.originAddresses);

    if (status != google.maps.DistanceMatrixStatus.OK) {
        alert('Error was: ' + status);
    } else {

        var origins = response.originAddresses;
        var destinations = response.destinationAddresses;
        var outputWalking = document.getElementById('outputWalking');
        outputWalking.innerHTML = '';

        var results = response.rows[0].elements;
        var result = results[0]
        console.log("Duration is %s", results[0].duration.value);
        var calorieBurn = 3 * results[0].duration.value / 60;
        var currentDate = new Date();
        console.log("%s", currentDate.getHours());

        var duration = Math.round(result.duration.value / 60);
        console.log("Duration is %s", duration);
        var arrivalTime = (currentDate.getMinutes() + duration);
        var arrivalMinute = arrivalTime % 60;
        var arrivalHour = currentDate.getHours() + Math.floor(arrivalTime / 60);
        console.log("Arrival hour is %s", arrivalHour);
        console.log("Arrival minute is %s", arrivalMinute);
        //var arrivalTime =
        outputWalking.innerHTML += 'Walking: <br>' + result.duration.text +
        //+ " and you burn " + calorieBurn + " calories!" +
        ' and you\'ll arrive ' + arrivalHour + ":" + arrivalMinute + '<br><br>';
    }
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
    console.log("Autocomplete is initialized");
    $(".form_submit").click(function () {
        var region = " Oslo";
        var origin = $("#from").val();
        origin = origin.concat(region);
        var destination = $("#to").val();
        destination = destination.concat(region);
        console.log("Origin: %s. Destination: %s", origin, destination);
        initialize(origin, destination);
    });23
});
		   

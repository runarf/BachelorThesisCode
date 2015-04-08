function initialize() {
    console.log("Starting autocomplete");
    var input = document.getElementById('#from');
    console.log("Input box is " + input);
    input = "Oslo";
    var options = {}
    var autocomplete = new google.maps.places.Autocomplete(input);
};

google.maps.event.addDomListener(window, 'load', initialize);
(function($){
 	/**
	* Change height dynamic, fixed footer if need
	*/
	function fixedFooter() {
	    $('#master').css('min-height', 0);
	    var heightNeed = 0;
	    // Caculate height, do no included padding
	    heightNeed = $(document).height() - ( $('#header').height() + $('#footer').height() + $('#toolbar').height() );

	    if ( $('#wpadminbar').length ) {
	        heightNeed -= $('#wpadminbar').height();
	    }
	    $('#master').css('min-height',heightNeed - 30);
	}

	
	$(window).resize(function() {
	   	fixedFooter();
	});
	$(document).ready(function() {
		fixedFooter();		
	});
})(window.jQuery)
var MainJS = (function($){
	/*
	* WooCommerce Grid / List toggle
	*/	
	function toggleGridProducts() {
		$('ul.products').toggleClass('layout-list');
	}

	/*
	* Draw Google Map
	*/
	function initializeGoogleMap(locations) {    	

		// find <div id="map" />, #maker have data-image as marker image
		/* 
			wp_enqueue_script( 'google-map-js', 'https://maps.googleapis.com/maps/api/js', '', '', false );
		*/
    	var mapCanvas = document.getElementById('map');
    	var marker_icon = $('#marker').data('image');
    	
    	if (locations.length > 0 ) {
    		// Create Map
	    	var mapOptions = {
		      center: new google.maps.LatLng(locations[0][1], locations[0][2]),
		      zoom: 12,
		      mapTypeId: google.maps.MapTypeId.ROADMAP,
		      mapTypeControl: false,
		      panControl: false,
		      ZoomControlStyle: {
			    style: google.maps.ZoomControlStyle.SMALL
			  }

		    }
		    
	    	var map = new google.maps.Map(mapCanvas,mapOptions);
	    	var infowindow = new google.maps.InfoWindow();

	    	// Draw marker
	    	var markers = [], i;

		    for (i = 0; i < locations.length; i++) {  
		    	var marker;
				marker = new google.maps.Marker({
					position: new google.maps.LatLng(locations[i][1], locations[i][2]),
					map: map,
					icon: marker_icon
				});

				markers.push(marker);

				google.maps.event.addListener(marker, 'click', (function(marker, i) {
					return function() {
					  infowindow.setContent(locations[i][0]);
					  infowindow.open(map, marker);
					  activeLocation(locations[i][1], locations[i][2]);
					}
				})(marker, i));


		    }

		    // event on location link
		    $('body').on('click', '.location-link', function(event) {
				map.setZoom(14);
				var id = $(this).data('id');
	    		map.setCenter(markers[id].getPosition());

	    		infowindow.setContent(locations[id][0]);
	    		infowindow.open(map, markers[id]);
	    		activeLocation(locations[id][1], locations[id][2]);

	    		window.setTimeout(function() {
				  map.panTo(markers[id].getPosition());
				}, 3000);
	    		
				event.preventDefault();
			});

		    // When resize window
		    $(window).on("debouncedresize", function( event ) {		
				google.maps.event.trigger(map, 'resize');	
			});
    	}
    	
    }

    /*
	* Add/Remove active class when clicked on location-link
	*/
    function activeLocation(latitude, longitude) {
    	$('.location-link').removeClass('active');
    	$('.location-link').filter(function(index) {
    		return ( $(this).data('latitude') == latitude && $(this).data('longitude') == longitude );
    	}).addClass('active');
    	
    }

	return {
		initializeGoogleMap: initializeGoogleMap,
		activeLocation: activeLocation,
		toggleGridProducts: toggleGridProducts
	}
})(window.jQuery);

jQuery(document).ready(function($) {

	// Init Google Map
	if ( $('#map').length ) {

		// Get all locations
		var locations = [];
		$.each($('.location-link'), function() {
			var data_latitude = $(this).data('latitude'),
				data_longitude = $(this).data('longitude'),
				data_address = $(this).data('address');
							
			if (data_latitude != '' && data_longitude != '' ) {
				var location = [ data_address,data_latitude,data_longitude];
				locations.push(location);
			};			
		});

		google.maps.event.addDomListener(window, 'load', MainJS.initializeGoogleMap(locations) );
	};
});
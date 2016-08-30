(function($){
 	// function to set the height on fly
	function fixedFooter() {
	    $('#master').css('min-height', 0);
	    var heightNeed = 0;
	    // Caculate height, do no included padding
	    heightNeed = $(document).height() - ( $('#header').height() + $('#footer').height() + $('#toolbar').height() );
	    console.log($('#header').height());
	    console.log($('#footer').height());
	    console.log($('#toolbar').height());
	    console.log($(document).height());
	    if ( $('#wpadminbar').length ) {
	        heightNeed -= $('#wpadminbar').height();
	    }
	    $('#master').css('min-height',heightNeed - 30);
	}

	// onResize bind of the function
	$(window).resize(function() {
	   	fixedFooter();
	});
	$(document).ready(function() {
		fixedFooter();
	});
})(window.jQuery)
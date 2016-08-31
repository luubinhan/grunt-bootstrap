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
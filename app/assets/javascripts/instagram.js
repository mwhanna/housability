$(document).ready(function(){
	$("#instagramButton").click(function(){
	    $("#instagramPhotos").fadeToggle();
	});
	$('#instagramUnlink').click(function(){
		unlinkInstagram();
		return false;
	});
});


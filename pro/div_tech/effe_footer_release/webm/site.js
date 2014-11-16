
function startVideo(){
	vid1 = document.getElementById('vid1');	
	vid2 = document.getElementById('vid2');
	vid3 = document.getElementById('vid3');
	vid4 = document.getElementById('vid4');
	
	vid1.addEventListener('ended', function(e) {playFirstVideo();});
	
	if (vid1.readyState > 2 ) {
		bgimg = document.getElementById('bgimg');
		bgimg.style["display"] = "none";
		bgimg.hidden = true;
		bgvid = document.getElementById('bgvid');
		bgvid.style["display"] = "inline";
		playFirstVideo();
	}
	else{
		setTimeout("startVideo()",1000);
	}
}

function playFirstVideo(){
	
	cur = document.getElementById('vid1');
	cur.style['display']="inline";
	cur.play();
}

window.onresize = function(event) {
	$(".content_r").css("padding-top",((window.innerHeight/2 - 225) + "px"));
}

jQuery(document).ready(function() {
	

	setTimeout(function(){
			if(localStorage.getItem("provideo") == "false"){
				$("#jquery_jplayer_1").jPlayer("pause");
			}
			else if(localStorage.getItem("provideo") === "true"){
				$("#jquery_jplayer_1").jPlayer("play");
			}
			else{
				localStorage.setItem("provideo","true");
				$("#jquery_jplayer_1").jPlayer("play");
			}
			$("#jquery_jplayer_1").bind($.jPlayer.event.play, function(){localStorage.setItem("provideo","true");});
			$("#jquery_jplayer_1").bind($.jPlayer.event.pause, function(){localStorage.setItem("provideo","false");});
		}, 1000);

	$(".content_r").css("padding-top",((window.innerHeight/2 - 225) + "px"));	
	setTimeout("startVideo()",1000);
});

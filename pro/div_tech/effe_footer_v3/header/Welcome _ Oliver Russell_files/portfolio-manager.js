var portfolioManager = {
	isIE7: false,
	isMobile: false,
	hasControls: false,
	currentWidth: null,
	vWidth: null,
	vHeight: null,
	isTransition: false,
	
	// timer vars
	portfolioId: 0, 
	portfolioTimer: null,
	
	init: function() {
		// Check Window Size
		portfolioManager.checkMobile();

		// On Resize
		$(window).resize(function() {
			portfolioManager.checkMobile();
			portfolioManager.adjustContentPosition();
		});

		// On Resize
		$(window).resize(function() {
			portfolioManager.checkMobile();
			portfolioManager.adjustContentPosition();
		});

		// On Orientation Change (iPad, iPhone, Android)
		window.onorientationchange = function() {
			portfolioManager.checkMobile();
			portfolioManager.adjustContentPosition();
		};

		// Items Event Listeners
		$("#thumbs a").click(function(event) {
			event.preventDefault();
			var button = $(this);
			portfolioManager.thumbClick (button, false);
		});

		// On Mobile, Close Project Button Event Listener
		$("#reveal-project a:first-child").click(function(event) {
			event.preventDefault();

			if (!portfolioManager.isTransition)
			{
				portfolioManager.isTransition = true;

				$("#project-item").slideUp(1000, "jswing", function() {
					$.scrollTo("#header-work");
					// $("#thumbs a img").css("opacity", 1);
					$('#thumbs a').removeClass('selected');
					
					portfolioManager.isTransition = false;
				});
			}

			return false;
		})
		
		// Init First Item
		$("#project-item").hide();
		// portfolioManager.startTransition(true, $("#thumbs a:first-child").attr("href"), false);
		
		
		// TIMER STUFF
		portfolioManager.portfolioId     = -1;
		portfolioLength = $("#thumbs a").length;
		portfolioManager.portfolioTimer  = $.timer ( function () {
			
			console.log("portfolioManager.isMobile = " + portfolioManager.isMobile);
			
			if (!portfolioManager.isMobile) {
				portfolioManager.portfolioId++; 
				if (portfolioManager.portfolioId >= portfolioLength) {
					portfolioManager.portfolioId = 0;
				}
			
				portfolioManager.portfolioActivate (portfolioManager.portfolioId);
			} else {
				portfolioManager.portfolioTimer.stop();
				$('a.toggle').addClass('play')
			};
			
		}, 5000, true).once();
		
		$('a.toggle').click(function(event) {
			event.preventDefault();
			portfolioManager.portfolioToggle();
		});
		
		$('a.previous').click(function(event) {
			event.preventDefault();
			portfolioManager.portfolioPrev();
		});
		
		$('a.next').click(function(event) {
			event.preventDefault();
			portfolioManager.portfolioNext();
		});
		
		
		
	},
	
	thumbClick: function (targetThumb, isTimerEvent) {
		
		var button  = $(targetThumb);
		portfolioManager.portfolioId = $('#thumbs a').index(targetThumb);
		
		$('#thumbs a').removeClass('selected');
		button.addClass('selected');
		
		if (!portfolioManager.isTransition) {
			
			// Update Contents
			var porfolioUrl = button.attr("href");
			portfolioManager.startTransition (false, porfolioUrl, !portfolioManager.isMobile);
			
			// Update Button State
			var thumb = button.children("img:first-child");
			// thumb.css("opacity", .4);
			
			// stop the timer
			if (!isTimerEvent && portfolioManager.portfolioTimer.active) {
				portfolioManager.portfolioToggle();
		    }
		}
	},
	
	
	portfolioToggle: function () {
		portfolioManager.portfolioTimer.toggle();
		// toggle class on button from play to pause
		
		$('a.toggle').removeClass('play')
		
		if (!portfolioManager.portfolioTimer.active) {
			$('a.toggle').addClass('play')
		};
	},
	
	portfolioPrev: function () {
		
		if (portfolioManager.portfolioTimer.active) {
			portfolioManager.portfolioToggle();
	    }
		
		portfolioManager.portfolioId--;
		if (portfolioManager.portfolioId < 0) {
			portfolioManager.portfolioId = portfolioLength-1;
		}

		portfolioManager.portfolioActivate (portfolioManager.portfolioId);
	},
	
	portfolioNext: function () {
		
		if (portfolioManager.portfolioTimer.active) {
	    	portfolioManager.portfolioToggle();
	    }
	    
		portfolioManager.portfolioId++; 
		if (portfolioManager.portfolioId >= portfolioLength) {
			portfolioManager.portfolioId = 0;
		}

		portfolioManager.portfolioActivate (portfolioManager.portfolioId);
	},
	
	portfolioActivate: function (targetID) {
		
		var button = $("#thumbs a:eq(" + targetID + ")");
		portfolioManager.thumbClick (button, true);
	},
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	getWidth: function() {
		var viewportWidth;

		// The more standards compliant browsers (mozilla/netscape/opera/IE7) use window.innerWidth and window.innerHeight
		if (typeof window.innerWidth != 'undefined')
		{
			viewportWidth = window.innerWidth;
		}

		// IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)
		else if (typeof document.documentElement != 'undefined' && typeof document.documentElement.clientWidth != 'undefined' && document.documentElement.clientWidth != 0)
		{
			viewportWidth = document.documentElement.clientWidth;
		}

		// Older versions of IE
		else
		{
			viewportWidth = document.getElementsByTagName('body')[0].clientWidth;
		}

		return viewportWidth;
	},
	
	checkMobile: function() {
		var width = portfolioManager.getWidth();

		if (width != portfolioManager.currentWidth)
		{
			portfolioManager.currentWidth = width;
			
			// Is this a version of IE?
			if($.browser.msie){
				userAgent = $.browser.version;
				userAgent = userAgent.substring(0, userAgent.indexOf('.')); 
				version = userAgent;

				if (version == 7) {
					portfolioManager.isIE7 = true;
				};
			}
			
			if (width < 768 || portfolioManager.isIE7)
			{
				portfolioManager.isMobile = true;
				
				// // stop the timer
				if (portfolioManager.portfolioTimer != null) {
					if (portfolioManager.portfolioTimer.active) {
						portfolioManager.portfolioToggle();
				    }
				};
				
				
/*
				$(function() {
					$("#project-item").hide();
				});
*/
				
				// $('#thumbs a').removeClass('selected');
				
			}
			else
			{
				portfolioManager.isMobile = false;
				
				
				// console.log("$('#thumbs a').hasClass('selected') = " + $('#thumbs a').hasClass('selected'));
				
				if (!$('#thumbs a').hasClass('selected')) {
					$('#thumbs a:first-child').addClass('selected');
					$('#thumbs a:first-child').trigger('click')
				};
				
				// $('#foo').trigger('click');
				// $('#thumbs a:first-child').trigger('click')
				$("#project-item").show();
			}
		}
	},
	
	startTransition: function (preventOpen, porfolioUrl, scrollWindow) {
		portfolioManager.isTransition = true;

		var preventOpen  = preventOpen;
		var porfolioUrl  = porfolioUrl;
		var scrollWindow = scrollWindow;

		if (!preventOpen && portfolioManager.isMobile)
		{
			$.scrollTo("#header-work");
		}

		if (portfolioManager.isMobile)
		{
			if ($("#project-item").is(":visible"))
			{
				var t = setTimeout(function() {
					$("#project-item").slideUp(1000, "jswing", function() {
						portfolioManager.getItem(preventOpen, porfolioUrl);
					});
				}, 1000)
			}
			else
				portfolioManager.getItem(preventOpen, porfolioUrl);
		}
		else
		{
			$("#project-item").fadeTo(200, 0, function() {
				portfolioManager.getItem(preventOpen, porfolioUrl);
			});
		}
	},
	
	getItem: function(preventOpen, porfolioUrl) {
		var preventOpen = preventOpen;

		$.ajax({
			type: "GET",
			dataType: "JSON",
			contentType: "application/json",
			url: porfolioUrl,
			success: function(data, textStatus, jqXHR) {
				portfolioManager.hasControls = false;

				// Populate Fields
				$("#project-image").attr("src", data[0].thumbnails[0].image);
				$("#project-image").attr("attr", data[0].thumbnails[0].image_title);
				$("#project-item h3").html(data[0].project_name);
				$("#project-content").html(data[0].description);

				// Hide Buttons
				$("#project-links div").hide();

				// Setup Video
				if (data[0].thumbnails[0].video_id.length > 0)
				{
					portfolioManager.hasControls = true;

					// Show Video Button
					var videoLink = $("#project-video-link");
					videoLink.show();

					// Init Video
					portfolioManager.changeVideo(data[0].thumbnails[0].video_id);

					// Overlay Window
					$("#project-video-trigger").fancybox({
						type: "inline",
						autoScale: false,
						centerOnScroll: true,
						showNavArrows: false,
						width: portfolioManager.vWidth,
						height: portfolioManager.vHeight,
						overlayColor: "#000",
						titlePosition: "outside",
						scrolling: "no",
						onComplete: function() {
							// Load Video
							$(function() {
								youTubeManager.loadVideo(portfolioManager.vWidth, portfolioManager.vHeight, !portfolioManager.isMobile);
							});
						},
						onClosed: function() {
							// Re-Init Video
							portfolioManager.changeVideo(data[0].thumbnails[0].video_id);
						}
					});
				}

				// External Links
				if (data[0].thumbnails[0].external_url.length > 0)
				{
					portfolioManager.hasControls = true;

					// Set External Button
					$("#project-site-link a:first-child").attr("href", data[0].thumbnails[0].external_url);
					$("#project-site-link a:first-child").attr("target", "_blank");
					$("#project-site-link").show();
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				alert("Hey, what's happening? It appears that we're too busy doing client work and are unable to load the portfolio. Please give us just a few minutes and try again.");
			},
			complete: function() {
				portfolioManager.endTransition(preventOpen);
				portfolioManager.adjustContentPosition();
			}
		});
	},
	
	endTransition: function(preventOpen) {
		var preventOpen = preventOpen;

		if (portfolioManager.isMobile)
		{
			if (!preventOpen)
				$("#project-item").slideDown(1000, "jswing");
		}
		else
		{
			$("#project-item").fadeTo(200, 1)
		}

		portfolioManager.isTransition = false;
	},
	
	changeVideo: function(id) {
		youTubeManager.changeVideo(id);

		// Set Video Size
		portfolioManager.vWidth = portfolioManager.currentWidth < 640 ? portfolioManager.currentWidth - 60 : 640;
		portfolioManager.vHeight = Math.floor((portfolioManager.vWidth / 4) * 3);

		$("#project-video, #video-item").css("width", portfolioManager.vWidth + "px");
		$("#project-video, #video-item").css("height", portfolioManager.vHeight + "px");
	},
	
	adjustContentPosition: function() {
		// Center Align
		if (portfolioManager.currentWidth > 768)
		{
			var projectItemHeight = $("#project-item").height();
			var projectDescriptionHeight = $("#project-description").height();

			if (portfolioManager.hasControls)
				$("#project-description").css("padding-top", Math.floor((projectItemHeight - (projectDescriptionHeight + 38)) / 2) + "px")
			else
				$("#project-description").css("padding-top", Math.floor((projectItemHeight - projectDescriptionHeight) / 2) + "px")
		}
		else
		{
			$("#project-description").css("padding-top", "40px") // Tablet Issues
		}
	}
	
	
	
	
	
	
	// var portfolioManager.portfolioId, portfolioEle, portfolioManager.portfolioTimer;
	// $(document).ready(function() {
	    // portfolioManager.portfolioId = 0;
	    // portfolioEle = $('.jquery-portfoliolery img');
	    // portfolioManager.portfolioTimer = $.timer(function() {
	    //     portfolioEle.eq(portfolioManager.portfolioId).stop(true,true).fadeOut(500);
	    //     portfolioManager.portfolioId++; if(portfolioManager.portfolioId >= portfolioEle.length) {portfolioManager.portfolioId = 0;}
	    //     portfolioEle.eq(portfolioManager.portfolioId).stop(true,false).fadeTo(500,1);
	    // }, 2000, true).once();
	// });
	// function portfolioNext() {
	//     if(portfolioManager.portfolioTimer.active) {
	//         portfolioManager.portfolioTimer.reset();
	//     }
	//     portfolioEle.eq(portfolioManager.portfolioId).stop(true,false).fadeOut(500);
	//     portfolioManager.portfolioId++; if(portfolioManager.portfolioId >= portfolioEle.length) {portfolioManager.portfolioId = 0;}
	//     portfolioEle.eq(portfolioManager.portfolioId).stop(true,false).fadeTo(500,1);
	// }
	// function portfolioPrev() {
	//     if(portfolioManager.portfolioTimer.active) {
	//         portfolioManager.portfolioTimer.reset();
	//     }
	//     portfolioEle.eq(portfolioManager.portfolioId).stop(true,false).fadeOut(500);
	//     portfolioManager.portfolioId--; if(portfolioManager.portfolioId < 0) {portfolioManager.portfolioId = portfolioEle.length-1;}
	//     portfolioEle.eq(portfolioManager.portfolioId).stop(true,false).fadeTo(500,1);
	// }
	
	
	
	
	
	
}

// You Tube Manager
var youTubeManager = {
	videoId: null,
	player: null,
	playerReady: false,
	completed: false,
	init: function() {
		var tag = document.createElement('script');
		tag.src = "http://www.youtube.com/player_api";

		var firstScriptTag = document.getElementsByTagName('script')[0];
		firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	},
	onYouTubePlayerAPIReady: function() {
	},
	changeVideo: function(id) {
		youTubeManager.clearVideo();

		if (id != null)
		{
			youTubeManager.videoId = id;
		}
		else
		{
			return;
		}

		// Clear Overlay Wrapper
		var videoItem = document.createElement("div");
		videoItem.setAttribute("id", "video-item");

		var projectVideo = document.getElementById("project-video");
		projectVideo.innerHTML = "";
		projectVideo.appendChild(videoItem);

		return false;
	},
	onPlayerReady: function(event) {
		youTubeManager.playerReady = true;
		// event.target.playVideo();
	},
	loadVideo: function(width, height, autoPlay) {
		youTubeManager.player = new YT.Player("video-item", {
			width: width,
			height: height,
			videoId: youTubeManager.videoId,
			events: {
				"onReady": autoPlay == true ? youTubeManager.onPlayerReady : null,
				"onError": function() {
					alert("Error playing video.");
				}
			}
		});
	},
	loadFramelessVideo: function() {
		document.location = "http://www.youtube.com/watch?v=" + youTubeManager.videoId;
	},
	clearVideo: function() {
		youTubeManager.player = null;
		youTubeManager.playerReady = false;
	},
	stopVideo: function() {
		youTubeManager.player.stopVideo();
	}
};

// Legacy Mapping
function onYouTubePlayerAPIReady() {
	youTubeManager.onYouTubePlayerAPIReady();
}

// On Load
$(function() {
	portfolioManager.init();
	youTubeManager.init();
});

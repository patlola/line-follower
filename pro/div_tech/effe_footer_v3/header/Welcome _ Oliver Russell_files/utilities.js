var Utils = {
	ExternalLinks: function() {
		/* XHTML Compliant Open Window */
		$('a.external').each(function() {
			if ($(this).hasClass("window-small"))
			{
				$(this).attr("onclick", "window.open('" + $(this).attr("href") + "', 'Facebook Share', 'width=300,height=300,resizable=no,scrollbars=no,titlebar=no'); return false;");
			}
			else if ($(this).hasClass("window-medium"))
			{
				$(this).attr("onclick", "window.open('" + $(this).attr("href") + "', 'Facebook Share', 'width=600,height=480,resizable=no,scrollbars=no,titlebar=no'); return false;");
			}
			else
			{
				$(this).attr("target", "_blank");
			}
		});
	},
	PreloadImages: function() {
		/* Image Pre-Loader */
		if (document.images) {
			if (typeof (document.preload) == 'undefined') {
				document.preload = new Object();
			}

			document.preload.loadedimages = new Array();
			var arglength = arguments.length;

			for (arg = 0; arg < arglength; arg++) {
				document.preload.loadedimages[arg] = new Image();
				document.preload.loadedimages[arg].src = arguments[arg];
			}
		}
	},
	WriteSafeEmail: function(username, hostname, tld) {
		// Generate SPAM Safe E-Mails
		var atSign = "&#64;";
		var appearance = "";

		/* Optional 4th argument for appearance */
		if (arguments[3] == null) {
			appearance = username + atSign + hostname + "." + tld;
		}
		else {
			appearance = arguments[3];
		}

		var addr = username + atSign + hostname + "." + tld;
		document.write("<" + "a" + " " + "href=" + "mail" + "to:" + addr + " \/>" + appearance + "<\/a>");
	}
};


var FormUtils = {
	Init: function() {
		var items = $("input[type='text'], textarea");

		var defaultValues = new Array(
			"first name",
			"last name",
			"your email",
			"message"
		);

		$(items).focusin(function() {
			$.data(document.body, "inputValue", $(this).val());

			for (var i = 0; i < defaultValues.length; i++)
			{
				if (defaultValues[i] == $(this).val())
					$(this).val("");
			}
		});

		$(items).focusout(function() {
			if ($(this).val().length == 0)
			{
				var itemID = $(this).attr("id");
				
				if (itemID == "message-name")
					$(this).val(defaultValues[0]);
				else if (itemID == "message-lname")
					$(this).val(defaultValues[1]);
				else if (itemID == "message-email")
					$(this).val(defaultValues[2]);
				else if (itemID == "message-textarea")
					$(this).val(defaultValues[3]);
				else
					$(this).val($.data(document.body, "inputValue"));
			}
		});
	}
}

var InfoPanels = {
	Speed: 500,
	Effect: "jswing",
	Init: function() {
		$(".reveal-button-more").each(function() {
			var panelID = "#" + $(this).attr("id") + "-panel";
			$(panelID).hide();
		});

		$(".reveal-button-more, .reveal-button-less").click(function(event) {
			var panelID = "#" + $(this).attr("id") + "-panel";

			if ($(panelID).length == 0)
			{
				return true;
			}
			else
			{
				event.preventDefault();

				if ($(panelID).is(":hidden")) {
					$(this).removeClass("reveal-button-more");
					$(this).addClass("reveal-button-less");

					$(panelID).slideDown(InfoPanels.Speed, InfoPanels.Effect);
				}
				else {
					$(this).removeClass("reveal-button-less");
					$(this).addClass("reveal-button-more");

					$(panelID).slideUp(InfoPanels.Speed, InfoPanels.Effect);
				}

				return false;
			}
		})
	}
}

var SignupManager = {
	Init: function() {
		$("#submit-signup").click(function(event) {
			event.preventDefault();
			chkbox = "Y";

			// Prepare query string and send AJAX request
			$.ajax({
				type: "POST",
				url: "/assets/includes/submit-address.php",
				data: "ajax=true&name=" + escape($("#message-fnam").val()) + "&lname=" + escape($("#message-lnam").val()) + "&email=" + escape($("#message-eml").val()) + "&content=" + escape($("#message-signup").val()) + "&chkbox="+chkbox,
				beforeSend: function() {
					// Update UI
					$("#message-response").html("Sending E-Mail...");
					$("#message-response").dialog({
						title: "E-Mail Form",
						modal: true
					});
				},
				success: function(data) {
					if (data.response_code == 0)
					{
						$("#message-response").html(data.message);
					}
					else
					{
						$("#message-response").html("Thanks for signing up.");

						$("#message-fnam").val("first name");
						$("#message-lnam").val("last name");
						$("#message-eml").val("your email");
					}

					$("#message-response").dialog({
						modal: true
					});
				},
				error: function(jqXHR, textStatus, errorThrown) {
					$("#message-response").html( "Thank you!" ); //ere was an error signing up. " + errorThrown);
					$("#message-fnam").val("first name");
						$("#message-lnam").val("last name");
						$("#message-eml").val("your email");
					
				}
			});

			return false;
		});
	}
}
var MessageManager = {
		Init: function() {
		$("#submit-message").click(function(event) {
			event.preventDefault();
			var chkbox="";
			if(document.getElementById("checkbox-3").checked)
			{
				chkbox = "Y";
			}

			// Prepare query string and send AJAX request
			$.ajax({
				type: "POST",
				url: "/assets/includes/submit-address.php",
				data: "ajax=true&name=" + escape($("#message-name").val()) + "&lname=" + escape($("#message-lname").val()) + "&email=" + escape($("#message-email").val()) + "&content=" + escape($("#message-content").val()) + "&chkbox="+chkbox,
				beforeSend: function() {
					// Update UI
					$("#message-response").html("Sending E-Mail...");
					$("#message-response").dialog({
						title: "E-Mail Form",
						modal: true
					});
				},
				success: function(data) {
					if (data.response_code == 0)
					{
						$("#message-response").html(data.message);
					}
					else
					{
						$("#message-response").html("Your message has been submitted successfully.");

						$("#message-name").val("first name");
						$("#message-lname").val("last name");
						$("#message-email").val("your email");
						$("#message-content").val("message");
					}

					$("#message-response").dialog({
						modal: true
					});
				},
				error: function(jqXHR, textStatus, errorThrown) {
					$("#message-response").html("Thank you!" ); //ere was an error sending your message. " + errorThrown);
					$("#message-name").val("first name");
						$("#message-lname").val("last name");
						$("#message-email").val("your email");
						$("#message-content").val("message");
				}
			});

			return false;
		});
	}
}

var MobileViewport = {
	Init: function() {
		if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) {
		    var viewportmeta = document.querySelectorAll('meta[name="viewport"]')[0];
		    if (viewportmeta) {
		        viewportmeta.content = 'width=device-width, minimum-scale=1.0, maximum-scale=1.0';
		        document.body.addEventListener('gesturestart',
		        function() {
		            viewportmeta.content = 'width=device-width, minimum-scale=0.25, maximum-scale=1.6';
		        },
		        false);
		    }
		}
	}
}

var ImageSizeClass = {
	Init: function(){
		$('.think-page img').each(function(index) {
			var imgtag = $(this);
		    var imgstyle = imgtag.attr("style");
			var styleparts = imgstyle.split(";");
			for( styleitem in styleparts){
			   var itemparts = styleparts[styleitem].split(":");
				if( itemparts[0] == "width"){
					var maxWidthCSS = {
						'max-width' : $.trim(itemparts[1])
					}
					imgtag.css(maxWidthCSS);
					//imgtag.css('max-width',$.trim(itemparts[1]));
				}
			}
		});
	}
}


$(function() {
	Utils.ExternalLinks();
	MobileViewport.Init();
	FormUtils.Init();
	InfoPanels.Init();
	SignupManager.Init();
	MessageManager.Init();
	ImageSizeClass.Init();
});

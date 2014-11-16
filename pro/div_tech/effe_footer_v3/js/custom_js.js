 $(window).load(function () {
    /*       Loading XML file                    */
     if (window.XMLHttpRequest)
	{
  		xmlhttp=new XMLHttpRequest();

	}
	else
	{
  	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.open("GET","data.xml",false);
	xmlhttp.send();
	xmlDoc=xmlhttp.responseXML;


	  var selector;
	  var insideLb=0;
	  var insideContact=0;
	  var insideHome=1;
	  var insideEvent=0;
	  var mainBcont=new Array();
       mainBcont[0]="#divHome";
       mainBcont[1]="#container";
       mainBcont[2]="#divContact"; 

	  function transit(transitSelect){
	  	transitSelect="#"+transitSelect;
	  var i;
	  for(i=0;i<mainBcont.length;i++)
	  {
	  	//alert(transitSelect);
	  	if($(mainBcont[i]).is(":visible"))
	  	{
	  		$(mainBcont[i]).hide("fold",{},5000,function(){

	  		$(transitSelect).show("scale",{},2000);
	  		});
	  		break;
	  	}
	  }
	  if(i===mainBcont.length)
	  {
	  	//alert(transitSelect);
	  	//$(transitSelect).show("scale",{},2000);
	  	$(transitSelect).show();
	  	//alert("Ansh");
	  }
	  
	  }
      var $container = $('#container');
      var currentSelect="Universe";
      $('.down').toggleClass("down",false);
      $("#selectEventBox").toggleClass("down");

      /*$('.mainB').click(function(){
      	     var hash=window.location.hash;
      	     if(hash.substring(1,hash.length)==="Home")
    	    	transit("Home");
    	     else if(hash.substring(1,hash.length)==="Event")
    	    	transit("container");
    	     else if(hash.substring(1,hash.length)==="Contact")
    	    	transit("divContact");
      });*/
/*                                 LightBox Control            */
   function closeLb()
   {
   	 insideLb=0;
   	 $("#overlay").fadeOut("fast");
     $("#clightbox").hide("scale",{},500);
	 
     //alert(selector);
     if(selector==undefined)
     window.location.hash="";
     else
     window.location.hash=selector;	
     return false;
   }

   function showLb(selectorLb)
   {
   	insideLb=1;
	//$("#clightbox,#overlay").fadeIn(300);
	$("#clightbox").show( "scale",{},500);
	$("#overlay").fadeIn(300);
	
    selectorLb=selectorLb.substring(2,selectorLb.length);
    //alert(categ);
    content=xmlDoc.getElementsByTagName(selectorLb)[0];
    //alert(content.childNodes[1].childNodes[0].nodeValue);
    $("#lbcontent").html(content.childNodes[1].childNodes[0].nodeValue);
    
       $("a#lb1").click(function(){
       $("#lbcontent").html(content.childNodes[1].childNodes[0].nodeValue);
 	   });
 	   $("a#lb2").click(function(){
       $("#lbcontent").html(content.childNodes[3].childNodes[0].nodeValue);
 	   });
 	   $("a#lb3").click(function(){
       $("#lbcontent").html(content.childNodes[5].childNodes[0].nodeValue);
 	   });
 	
   }
    $("a.clickLb").click(function(){
	showLb($(this).attr('href'));

    });
  $("#overlay,#lbclose").click(function(){
 	   	if(insideLb===1)
 	   	{
 	   		closeLb();
 	   	}
     	
   });
$(document).keyup(function(e) {

  if (e.keyCode == 27) { 
  	if(insideLb===1)
	closeLb();
}
});


      $container.isotope({
        itemSelector: '.EventBox',
        getSortData : {
          eventname : function( $elem ) {
            return $elem.find('.eventname').text();
          },
          date : function( $elem ) {
            return parseInt( $elem.find('.date').text(), 10 );
          },
          eventtype : function( $elem ) {
            return $elem.attr('event-type');          }
         
        }

   });

      function subMenuChange(selectorT) {
      	if(insideLb===1)
      	closeLb();
      	var idSelect="#select";
      	
      	var selectName;
        if(selectorT==="")
        	selectorT="#EventBox";
        selectorT=selectorT.substring(2,selectorT.length);
        idSelect=idSelect+selectorT;
        $('.down').toggleClass("down",false);
        $(idSelect).toggleClass("down");
      	selectName=selectorT;
      	selectorT="."+selectorT+",.BoxPerm";
      	$container.isotope({ filter:selectorT  });
      //	alert(selector);
      	$('#filterEvent input[type="checkbox"]').each(function() {
       		    var temp=$(this).attr("name");
       		    if(temp===selectName)
       		    {
       		    	$(this).attr("checked",true);

       		    }
       		    else
       		    {
       		    	$(this).attr("checked",false);

       		    }
       		    if(selectName==="EventBox")
       		    $(this).attr("disabled",false);
       			else
       		    $(this).attr("disabled",true);
       	});

       $('#filterDay input[type="checkbox"]').each(function() {
         $(this).attr("checked",false);
       });

     };


       //Events Submenu Effect
      /*$('#teest').click(function(){
       	alert("Anshuman");
       });*/

      $('a.iconContainer').click(function(){
        
      	selector = $(this).attr('href');
      	subMenuChange(selector);
     
     });

         //Customized Filter 
       $('.checkFilter').change(function(){
      		
      		var valsEvent = [];
      		var valsDay = [];
     		$('#filterEvent :checked').each(function() {
       		valsEvent.push($(this).val());
     	});
     		$('#filterDay :checked').each(function() {
       		valsDay.push($(this).val());
     	});
     		if(valsEvent.length===0)
     		{
     			$('#filterEvent input[type="checkbox"]').each(function() {
       		    valsEvent.push($(this).val());
       		});

     		}


     			if(valsDay.length===0)
     		{
     			$('#filterDay input[type="checkbox"]').each(function() {
       		    valsDay.push($(this).val());
       		});
     			
     			
     		}



     		var selector=".BoxPerm";
     		for(var i in valsEvent)
     		{
     			for(var j in valsDay)
     			{
     				selector=selector+","+"."+valsEvent[i]+"."+valsDay[j];
     			}
     		}
     		$container.isotope({ filter:selector });
     		
      });

       /*  Enabling all Selections in Customized Search...Using Click on Change Settings*/

       $("#changeSelection").click(function(){
       	$('#filterEvent input[type="checkbox"]').each(function() {
       		    $(this).attr("disabled",false);
       	});
        $('.down').toggleClass("down",false);
        $("#selectEventBox").toggleClass("down");
        selector="";
       });

      

     //Hash Change
  	$(window).hashchange( function(){
  		if(insideLb===0)
  		{
  			 var hash = location.hash;
  			 if(hash===""||hash==="#")
  			 	transit("divHome");
  			 else if(hash.length===1||( hash.length>1&&hash[1]==='c'))
    		 subMenuChange(hash);
    		else if(hash.length>1&&hash[1]==='e')
    		showLb(hash);
    	    else if(hash.length>1&&hash.substring(1,hash.length)==="Home")
    	    	transit("divHome");
    	     else if(hash.length>1&&hash.substring(1,hash.length)==="Event")
    	    	transit("container");
    	     else if(hash.length>1&&hash.substring(1,hash.length)==="Contact")
    	    	transit("divContact");
    	    else if(hash.length>1)
    	    {
    	    	//Some code to wrong URL
    	    }
    	    
  		}
   
  	})

  	$(window).hashchange();
      
    
	
	
	//ImageHover //////////////////////////
	$(function(){
		$('.EventBox img').adipoli({
			'startEffect' : 'transparent',
			'hoverEffect' : 'foldLeft'
		});
	});
  $(function() {
				
				var Photo	= (function() {
						
						// list of thumbs
					var $list		= $('#pe-thumbs'),
						// the images
						$elems		= $list.find('img'),
						// maxScale : maximum scale value the image will have
						// minOpacity / maxOpacity : minimum (set in the CSS) and maximum values for the image's opacity
						settings	= {
							maxScale	: 1.4,
							maxOpacity	: 0.9,
							minOpacity	: Number( $elems.css('opacity') )
						},
						init		= function() {
							
							// minScale will be set in the CSS
							settings.minScale = _getScaleVal() || 1;
							_initEvents();
						
						},
						// Get Value of CSS Scale through JavaScript:
						// http://css-tricks.com/get-value-of-css-rotation-through-javascript/
						_getScaleVal= function() {
						
							var st = window.getComputedStyle($elems.get(0), null),
								tr = st.getPropertyValue("-webkit-transform") ||
									 st.getPropertyValue("-moz-transform") ||
									 st.getPropertyValue("-ms-transform") ||
									 st.getPropertyValue("-o-transform") ||
									 st.getPropertyValue("transform") ||
									 "fail...";

							if( tr !== 'none' ) {	 

								var values = tr.split('(')[1].split(')')[0].split(','),
									a = values[0],
									b = values[1],
									c = values[2],
									d = values[3];

								return Math.sqrt( a * a + b * b );
							
							}
							
						},
						_initEvents	= function() {
							
							// the proximity event
							$elems.on('proximity.Photo', { max: 80, throttle: 10, fireOutOfBounds : true }, function( event, proximity, distance ) {
								
								var $el			= $(this),
									$li			= $el.closest('li'),
									scaleVal	= proximity * ( settings.maxScale - settings.minScale ) + settings.minScale,
									scaleExp	= 'scale(' + scaleVal + ')';
								
								// change the z-index of the element once it reaches the maximum scale value
								( scaleVal === settings.maxScale ) ? $li.css( 'z-index', 1000 ) : $li.css( 'z-index', 1 );
								
								$el.css({
									'-webkit-transform'	: scaleExp,
									'-moz-transform'	: scaleExp,
									'-o-transform'		: scaleExp,
									'-ms-transform'		: scaleExp,
									'transform'			: scaleExp,
									'opacity'			: ( proximity * ( settings.maxOpacity - settings.minOpacity ) + settings.minOpacity )
								});

							});
						
						}
					
					return {
						init	: init
					};
				
				})();
				
				Photo.init();
				
			});
});

// JS Script for LightBox Navigation Menu..

		$(document).ready(function() {
		
			$('#menu-jquery li a').hover(
				
					function() {
						
						$(this).css('padding', '5px 15px')
								 .stop()
								 .animate({'paddingLeft'	: '25px', 
											 'paddingRight'	: '25px', 
											 'backgroundColor':'rgba(0,0,0,0.5)'}, 
											 'fast');
					}, 
					
					function() {
						
						$(this).css('padding', '5px 25px')
								 .stop()
								 .animate({'paddingLeft'	: '15px', 
								 			'paddingRight'		: '15px', 
								 			'backgroundColor' :'rgba(0,0,0,0.2)'}, 
								 			'fast');
				
				}).mousedown(function() {
			
					$(this).stop().animate({'backgroundColor': 'rgba(0,0,0,0.1)'}, 'fast');

				}).mouseup(function() {
				
					$(this).stop().animate({'backgroundColor': 'rgba(0,0,0,0.5)'}, 'fast');
				});
				
			});
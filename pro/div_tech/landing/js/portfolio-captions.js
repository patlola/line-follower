/*author:enavu Tutorial: "Making A Cool Thumbnail Effect With Zoom And Captions"*/

$(window).load(function(){
var thumbnail = {
imgIncrease : 100, 
effectDuration : 400,
imgWidth : $('.portfolio ul li').find('img').width(), 
imgHeight : $('.portfolio ul li').find('img').height() 
};
$('.portfolio ul li').css({ 
'width' : thumbnail.imgWidth, 
'height' : thumbnail.imgHeight 
});
$('.portfolio ul li').hover(function(){
$(this).find('img').stop().animate({
width: parseInt(thumbnail.imgWidth) + thumbnail.imgIncrease,
left: thumbnail.imgIncrease/2*(-1),
top: thumbnail.imgIncrease/2*(-1)
},{ 
"duration": thumbnail.effectDuration,
"queue": false
});
$(this).find('.caption:not(:animated)').slideDown(thumbnail.effectDuration);
}, function(){
$(this).find('img').animate({
width: thumbnail.imgWidth,
left: 0,
top: 0
}, thumbnail.effectDuration);
$(this).find('.caption').slideUp(thumbnail.effectDuration);
});
});

var box = $('.EventBox');

box.bind('proximity', {max:300}, function(e, proximity, distance){
                         
                        $(this).children('img').css('-webkit-filter', 'grayscale('+ (100-proximity*100) +'%)');                         
						$(this).children('img').css('-moz-filter', 'grayscale('+ (100-proximity*100) +'%)');                         
                
});


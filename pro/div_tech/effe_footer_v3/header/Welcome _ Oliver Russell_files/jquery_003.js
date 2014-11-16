$.scrollTo = function(sectionID) {
    $("html,body").animate({
        scrollTop: ($(sectionID).offset().top - 20),
		easing: "jswing"
    }, 900);
};
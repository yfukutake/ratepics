/* global $*/

var initialSize = 60;
var padding = 100;
var animDuration = 300;

function showImage(img) {

    var windowWidth = $(window).width();
    var windowHeight = $(window).height();
    var windowAspectRatio = windowWidth / windowHeight;
    var imageAspectRatio = img.width / img.height;
    var dispWidth;
    var dispHeight;
    if (windowAspectRatio > imageAspectRatio) {
        dispHeight = windowHeight - padding;
        dispWidth = dispHeight * imageAspectRatio;
    } else {
        dispWidth = windowWidth - padding;
        dispHeight = dispWidth / imageAspectRatio;
    }

    $(img).css({
        width: dispWidth + "px",
        height: dispHeight + "px",
        display: "none",
    });

    $(".popup-content").html(img);

    $(".popup-content").animate({
        width: dispWidth + "px",
        height: dispHeight + "px",
    
        "margin-left": -dispWidth / 2 + "px",
        "margin-top": -dispHeight / 2 + "px",
    }, animDuration, "swing", function() {
      
        $(img).fadeIn(animDuration);
    });
}


function showPopup(imageUrl) {
    $(".popup-content").html("");

    $(".overlay").fadeIn(animDuration);

    $(".popup-content").css({
        width: initialSize + "px",
        height: initialSize + "px",
        "margin-left": -initialSize / 2 + "px",
        "margin-top": -initialSize / 2 + "px",
    });

    var img = new Image();
    img.onload = function() {
        showImage(img);
    };
    img.src = imageUrl;
}

function closePopup() {
    $(".overlay").fadeOut(animDuration);
}

$(document).ready(function() {
    $(".popup").click(function() {
        showPopup($(this).attr("href"));
        return false;
    });

    $(".overlay").click(function() {
        closePopup();
        return false;
    });
});

$(document).ready(function() {
    $("img").hover(function() {
        $(this).next(".layer").css({
            "opacity": "1",
        });
        $(this).css({
            "opacity":"0.8",
        });
    }, function() {
        $(this).next(".layer").css({
            "opacity": "0",
        });
        $(this).css({
            "opacity":"1",
        });
    });
    
    $(".layer").hover(function() {
        $(this).css({
            "opacity": "1",
        });
        $(this).prev("img").css({
            "opacity":"0.8",
        });
    }, function(){
        $(this).css({
            "opacity": "0",
        });
        $(this).prev("img").css({
            "opacity":"1",
        });
    });
    
});


// move the page down a little bit because of the admin bar. 
$(document).ready(function () {
   // if ($('.navbar-admin').css("display") == "block") {
    $(".header-container").css("margin-top", "1px");
   // $("#PortBan").css("margin-top", "60px");
    //}

    var $win = $(window);
    $win.resize(function () {
        if ($win.width() > 768)
            $('#PortBan').css("margin-top", "60px");
        else
            $('#PortBan').css("margin-top", "50px");
    }).resize();
});
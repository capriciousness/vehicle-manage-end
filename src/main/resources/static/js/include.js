$(function(){
    $.get("header.html", function(data){
        $("#header").html(data);
    })
    $.get("nav.html", function(data){
        $("#nav").html(data);
    })
})
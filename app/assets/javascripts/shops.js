// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  requestOpenShops();
})

function requestOpenShops() {
  $("#search_button").on('click', function(){
    $.ajax({
      url: location.href+'/../shops/show.js',
      type: "POST",
    });
    $("#search_button").hide();
  })
}

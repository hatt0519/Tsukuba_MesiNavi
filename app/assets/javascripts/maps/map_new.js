function initMap(lat, lng) {
  var shop_place_id = document.getElementById("shop_place_id");
  var location = {lat: lat, lng: lng};

  $("#introduction").hide();
  $("#map").show();
  drawMap(location);

  shop_place_id.addEventListener('change', function(){
    var place_id = shop_place_id.value;
    var shop_name_hidden = document.getElementById("shop_name");
    shop_name_hidden.value = shop_place_id[shop_place_id.selectedIndex].text
    showShopCandidateLocation(place_id);
  });
}

function showShopCandidateLocation(id) {
  var location = document.getElementById(id).value;
  setMapStatus(JSON.parse(location));
}

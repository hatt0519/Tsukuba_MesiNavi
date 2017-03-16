function initMap() {
  var params = getUrlParams();
  var location = {lat: params.lat, lng: params.lng};
  drawMap(location);
}

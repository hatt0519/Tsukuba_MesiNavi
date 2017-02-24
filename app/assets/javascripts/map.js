function initMap() {
  var params = getUrlParams();
  var location = {lat: params.lat, lng: params.lng};
  var map = new google.maps.Map(document.getElementById('map'), {
      center: location,
      zoom: 11
  });
  var marker = new google.maps.Marker({
    position: location,
    map: map,
  });
}

function getUrlParams() {
  var params = {};
  var params_array = location.search.substring(1).split("&");
  for(var i=0; i < params_array.length; i++) {
    var forcused_param = params_array[i];
    var equalPosition = forcused_param.search(/=/);
    if(equalPosition != -1) {
      var key = forcused_param.slice(0, equalPosition);
      if(key != '') {
        var value = forcused_param.slice(forcused_param.indexOf('=', 0) + 1);
        params[key] = (key == 'lat' || key == 'lng') ? Number(decodeURI(value)) : decodeURI(value);
      }
    }
  }
  return params;
}

function detectUserAgent() {
  var useragent = navigator.userAgent;
  if (useragent.indexOf('iPhone') != -1 || useragent.indexOf('Android') != -1 ) {
      mapdiv.style.width = '100%';
      mapdiv.style.height = '100%';
    } else {
      mapdiv.style.width = '600px';
      mapdiv.style.height = '800px';
    }

}

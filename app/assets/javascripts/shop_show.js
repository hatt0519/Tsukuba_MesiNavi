$(function(){
  showRegistedModal();
});

function showRegistedModal() {
  var params = getUrlParams();
  var needShow = params.registed;
  var id = "#registed";
  showModal(id, needShow);
}

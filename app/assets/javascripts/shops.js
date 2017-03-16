// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){
  requestOpenShops();
  selectCategoryOther();
  editCategories();
  submitCategories();
  searchForShop();
  showLoadingWaitingSaveShop();
  validateShopNameInput();
})

function requestOpenShops() {
  $("#search_button").on('click', function(){
    $.ajax({
      url: location.href+'/../shops/show_now_open.js',
      type: "POST",
    });
    $("#search_button").hide();
  })
}

function editCategories() {
  $("#categories").on('click',"button", function(){
    var params = getUrlParams();
    var url = location.href.split('?').shift();
    $.ajax({
      url: url + '/../edit_categories.js',
      type: "POST",
      data: {shop_id: params.shop_id}
    });
  });
}

function toggleCategoryOther(checked) {
  if(checked) {
    $("#category_other_input").show();
  } else {
    $("#category_other_input").hide();
  }
}

function selectCategoryOther() {
  $("#edit_categories").on('click', '#category_9', function(){
    var checked = $(this).prop('checked');
    toggleCategoryOther(checked);
  });
}

function initCategoryOther() {
  var checked = $("#category_9").prop('checked');
  toggleCategoryOther(checked);
}

function submitCategories() {
  $("#edit_categories").on("click", "#submit_categories", function(){
    var checkBoxes = document.getElementsByClassName("category_checkbox");
    var checkedBoxes = Array.prototype.filter.call(checkBoxes, function(checkbox){return checkbox.checked;});

    var valueSelectedCheckedBoxes = checkedBoxes.map(function(checkedBox){
      return checkedBox.value;
    });

    var params = getUrlParams();
    var url = location.href.split('?').shift();
    var sendingData = {categories: valueSelectedCheckedBoxes, shop_id: params.shop_id};
    if(sendingData.categories.includes('9')) {
      var categoryOther = $("#category_other").val();
      sendingData["category_other"] = categoryOther;
    }

    $.ajax({
      url: url + '/../update_categories.js',
      type: "POST",
      data: sendingData
    });
  });
}

function addCategoryOtherInput() {
  $("#category_other_input").on('click', '#add_category_other_input', function(){

  });
}

function searchForShop() {
  $("#search").on('click', function() {
    var shopName = document.getElementById("shop_name_text").value;
    var urlArray = location.href.split("/");
    var action = urlArray[urlArray.length - 1];
    var url = "";
    if(action === "new") {
      url = location.href + '/../search.js';
    } else {
      url = location.href + '/search.js';
    }
    $.ajax({
      url: url,
      type: "POST",
      data: {name: shopName}
    });
  });
}

function showLoadingWaitingSaveShop() {
  $("#shop_candidate").on('click', "#submit_shop_info", function(){
    var id = "#loading";
    showModal(id, true);
  });
}

function validateShopNameInput() {
  var shopNameText = document.getElementById("shop_name_text");
  if(shopNameText) {
    shopNameText.addEventListener('keyup', function(){
      var text = shopNameText.value;
      var button = document.getElementById("search");
      button.disabled = text === "";
    });
  }
}

function showModal(id, needShow) {
  if(needShow) {
    $(id).modal("show");
  }
}

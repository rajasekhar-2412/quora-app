// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require best_in_place
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
  $('.best_in_place').bind("ajax:success", function(event, data, status, xhr){ 
  	var parsed_data = jQuery.parseJSON(data);
  	$("#"+parsed_data['id']).text(parsed_data['updated']);
  })
});

var wideLayout = function() {
  $('.lightwell').addClass("full-width", function() { $(this).removeClass("col-sm-3"); });
  $('.fa-align-justify').addClass("selected");
  $('.fa-th').removeClass("selected");
};
var gridLayOut = function() {
  $('.lightwell').addClass("col-sm-3", function() {$(this).removeClass("full-width"); });
  $('.fa-align-justify').removeClass("selected");
  $('.fa-th').addClass("selected");
};
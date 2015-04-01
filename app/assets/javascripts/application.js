// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ez-bg-resize
//= require jquery-ui



$(function(){
  $('#notice').delay(3000).slideUp(200);
  $('#error').delay(3000).slideUp(200);
  $('#bodywrap').css({'min-height': $(window).height() - 160});
  $('#arecord').click(function(){
    $('#arecord').addClass('active');
    $('#arecord_tab').removeClass('hide');
    $('#cname, #other').removeClass('active');
    $('#cname_tab, #other_tab').addClass('hide');
  });
  $('#cname').click(function(){
    $('#cname').addClass('active');
    $('#cname_tab').removeClass('hide');
    $('#arecord, #other').removeClass('active');
    $('#arecord_tab, #other_tab').addClass('hide');
  });
  $('#other').click(function(){
    $('#other').addClass('active');
    $('#other_tab').removeClass('hide');
    $('#arecord, #cname').removeClass('active');
    $('#arecord_tab, #cname_tab').addClass('hide');
  });
});

$(document).on('click', '.remove_fields', function(event){
  $(this).prev('input[type=hidden]').val('1');
  $(this).closest('fieldset').hide();
  event.preventDefault();
});


function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}


// $(document).ready(function () {
//       $('.dropdown-toggle').dropdown();
// });

// jQuery(document).ready(function() {
//   jQuery("abbr.timeago").timeago();
// });

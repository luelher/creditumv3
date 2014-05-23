// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
   $("#casa_comercial").change(function(evento){
      $.post("/search_users.js", $('#filter_form').serialize(), 'script')
   });
})

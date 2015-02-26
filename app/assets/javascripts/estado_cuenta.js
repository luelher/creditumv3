// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){

  Morris.Donut({
    element: 'graf-estado-cuenta',
    data: [
      {label: "Acertadas", value: $("#acertadas").val()},
      {label: "Fallidas", value: $("#fallidas").val()},
    ]
  });

  $('#tabla_acertadas').DataTable( {
            "language": datatables_es
        })
  $('#tabla_fallidas').DataTable( {
            "language": datatables_es
        })

})
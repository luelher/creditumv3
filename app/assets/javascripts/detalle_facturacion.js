// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready( function() {
   $('#id').change( function() {
      location.href = "/detalle_facturacion/" + $(this).val();
   });


  $('#tabla_acertadas_a').DataTable( {
            "language": datatables_es
        })
  $('#tabla_fallidas_b').DataTable( {
            "language": datatables_es
        })
});
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(window).load(function() {

  $('.consumos').click(function(){

    if($('#factura_fecha_desde').val() != '' && $('#factura_fecha_hasta').val() != '' && $('#factura_id_cliente').val()!=''){
      $.getJSON( '/facturas/buscar/'+$('#factura_fecha_desde').val().replace(/\//g,'-')+'/'+$('#factura_fecha_hasta').val().replace(/\//g,'-')+'/'+$('#factura_id_cliente').val(), function( data ) {
        
        $('#factura_validas').val(data['validas'])
        $('#factura_fallidas').val(data['fallidas'])
      });
    }else{
      alert("Debe seleccionar el cliente, y las fechas desde y hasta")
    }

    return false;
  });


  $(".combos_fechas").datepicker();
  $('#tabla_listado').DataTable({
            "language": datatables_es
        })
  
});

// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  
  $(".fechas").datepicker({showTime: false, showButtonPanel: true});
  
  $(".new-row").on("click", function() {
    str = '<tr><td><input name="credito[0][factura]" placeholder="Nro Factura" type="text" value=""></td><td><input name="credito[0][fecha_compra]" placeholder="Fecha Factura" type="text" value="", class: "fechas"></td><td><input name="credito[0][pago_mes]" placeholder="Pago Mensual" type="text" value=""></td><td><input name="credito[0][num_giros]" placeholder="Nro Giros" type="text" value=""></td><td><input name="credito[0][monto]" placeholder="Monto Total" type="text" value=""></td><td><select class="form-control" name="credito[0][experiencia]"><option value="0">0 (Registro Nuevo)</option><option value="1">1 (Sin Retraso)</option><option value="2">2 (&lt; 30 Días)</option><option value="3">3 (&gt; 30 y &lt; 60 Días)</option><option value="4">4 (&gt; 60 y &lt; 90 Días)</option><option value="5">5 (&gt; 90 y &lt; 120 Días)</option><option value="6">6 (&gt; 120 y &lt; 180 Días)</option><option value="20">20 (&gt; 180 Días)</option><option value="21">21 (Incobrable)</option></select></td></tr>';

    str = str.replace("[0]", "["+$('tbody tr').length+"]");
    str = str.replace("[0]", "["+$('tbody tr').length+"]");
    str = str.replace("[0]", "["+$('tbody tr').length+"]");
    str = str.replace("[0]", "["+$('tbody tr').length+"]");
    str = str.replace("[0]", "["+$('tbody tr').length+"]");
    str = str.replace("[0]", "["+$('tbody tr').length+"]");

    $('.table > tbody:last').append(str);

    $(".fechas").datepicker({showTime: false, showButtonPanel: true});

    return false;
  });


  $(".grid-import tbody .seach_persona").change(function(evento){
    $.post("/search_personas.js", "cedula_name="+this.name+"&cedula="+this.value, 'script')
  });

  $(".grid-import tbody .seach_factura").change(function(evento){
    $.post("/search_facturas.js", "factura_name="+this.name+"&factura="+this.value+"&id_cliente_persona="+$(this).parent().prevAll().last().first().children()[1].value, 'script')
  });

})

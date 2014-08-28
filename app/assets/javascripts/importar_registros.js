// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  
  $(".fechas").datepicker({showTime: false, showButtonPanel: true});
  
  $(".new-row").on("click", function() {
    str = '<tr class=""><td><input class="seach_persona" id="credito_99_cliente_persona_attributes_persona_natural_attributes_cedula" name="credito[99][cliente_persona_attributes][persona_natural_attributes][cedula]" placeholder="Cedula" type="text"><input id="credito_99_cliente_persona_attributes_id_cliente_persona" name="credito[99][cliente_persona_attributes][id_cliente_persona]" type="hidden"><input id="credito_99_id" name="credito[99][id]" type="hidden"></td><td><input id="credito_99_cliente_persona_attributes_persona_natural_attributes_nombre" name="credito[99][cliente_persona_attributes][persona_natural_attributes][nombre]" placeholder="Nombre" type="text"></td><td><input id="credito_99_cliente_persona_attributes_persona_natural_attributes_apellido" name="credito[99][cliente_persona_attributes][persona_natural_attributes][apellido]" placeholder="Apellido" type="text"></td><td><input class="seach_factura" id="credito_99_factura" name="credito[99][factura]" placeholder="Nro Factura" type="text"></td><td><input class="fechas hasDatepicker" id="credito_99_fecha_compra" name="credito[99][fecha_compra]" placeholder="Fecha Factura" type="text"></td><td><input id="credito_99_pago_mes" name="credito[99][pago_mes]" placeholder="Pago Mensual" type="text"></td><td><input id="credito_99_num_giros" name="credito[99][num_giros]" placeholder="Nro Giros" type="text"></td><td><input id="credito_99_monto" name="credito[99][monto]" placeholder="Monto Total" type="text"></td><td><select id="credito_99_experiencia" name="credito[99][experiencia]"><option value="0">0 (Registro Nuevo)</option><option value="1">1 (Sin Retraso)</option><option value="2">2 (&lt; 30 Días)</option><option value="3">3 (&gt; 30 y &lt; 60 Días)</option><option value="4">4 (&gt; 60 y &lt; 90 Días)</option><option value="5">5 (&gt; 90 y &lt; 120 Días)</option><option value="6">6 (&gt; 120 y &lt; 180 Días)</option><option value="20">20 (&gt; 180 Días)</option><option value="21">21 (Incobrable)</option></select></td></tr>';

    str = str.replace(/99/g, $('tbody tr').length);

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

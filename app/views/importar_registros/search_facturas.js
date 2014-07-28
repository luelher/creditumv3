<% if @credito  %>
    $("input[name='<%= @name_fecha_compra %>']").val("<%= @credito.fecha_compra %>");
    $("input[name='<%= @name_pago_mes %>']").val("<%= @credito.pago_mes %>");
    $("input[name='<%= @name_num_giros %>']").val("<%= @credito.num_giros %>");
    $("input[name='<%= @name_monto %>']").val("<%= @credito.monto %>");
    $("input[name='<%= @name_id %>']").val("<%= @credito.id %>");
    $("input[name='<%= @name_experiencia %>']").focus();
<% end %>
<% if @persona  %>
    $("input[name='<%= @name_nombre %>']").val("<%= @persona.nombre %>");
    $("input[name='<%= @name_apellido %>']").val("<%= @persona.apellido %>");
    <% if @cliente_persona  %>
      $("input[name='<%= @name_id_cliente_persona %>']").val("<%= @cliente_persona.id_cliente_persona %>");
    <% end %>
    $("input[name='<%= @name_factura %>']").focus();
<% end %>
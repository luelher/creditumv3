<% if @usuarios  %>
    $('#usuario').html("<%= escape_javascript select_tag(:usuario, options_from_collection_for_select(@usuarios, :cedula, :nombre) , class: 'form-control', :prompt => 'Selccione Usuario') %>");
<% end %>
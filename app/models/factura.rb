class Factura < ActiveRecord::Base
  self.table_name = 'facturas'
  self.primary_key = :id_factura
  self.alias_attribute :id, :id_factura

  belongs_to :cliente, primary_key: 'id_cliente', foreign_key: "id_cliente"

  

end

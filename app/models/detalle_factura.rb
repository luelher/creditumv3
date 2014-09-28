class DetalleFactura < ActiveRecord::Base
  self.table_name = 'detalle_facturas'

  belongs_to :factura, primary_key: 'id_factura', foreign_key: "id_factura"
  belongs_to :persona_juridica, primary_key: 'id_persona', foreign_key: "rif"
  belongs_to :persona_natural, primary_key: 'id_persona', foreign_key: "cedula"
  has_one :usuario, primary_key: 'cedula_usuario', foreign_key: "cedula"


  scope :acertadas, ->{where(:status => 1)}
  scope :fallidas, ->{where(:status => 0)}


end

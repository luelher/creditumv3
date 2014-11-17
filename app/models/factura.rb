class Factura < ActiveRecord::Base
  self.table_name = 'facturas'
  self.primary_key = :id_factura
  self.alias_attribute :id, :id_factura

  before_validation :valores_por_defecto

  belongs_to :cliente, primary_key: 'id_cliente', foreign_key: "id_cliente"
  has_many :detalles, :class_name => "DetalleFactura", primary_key: 'id_factura', foreign_key: "id_factura", dependent: :destroy

  scope :por_cliente, ->(cli) {where(:id_cliente => cli).order(:fecha_hasta => :desc)}  

  def casa_y_cliente
    unless cliente.nil?
      unless cliente.casa_comercial.nil?
        "#{cliente.casa_comercial.nombre} - #{cliente.nombre}"
      else
        cliente.nombre
      end
    else
      "Sin Cliente"
    end    
  end

  def valores_por_defecto
    self.precio_ok = 0
    self.precio_fallida = 0
    self.totalv = 0
    self.totalf = 0
    self.descuento = 0
    self.totald = 0
    self.total = 0
  end

end

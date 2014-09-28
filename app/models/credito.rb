class Credito < ActiveRecord::Base

  FORMATOS_ARCHIVOS = {'Generica de Creditum' => '0'}
  EXPERIENCIAS = {
    "0 (Registro Nuevo)" => "0",
    "1 (Sin Retraso)" => "1",
    "2 (< 30 Días)" => "2",
    "3 (> 30 y < 60 Días)" => "3",
    "4 (> 60 y < 90 Días)" => "4",
    "5 (> 90 y < 120 Días)" => "5",
    "6 (> 120 y < 180 Días)" => "6",
    "20 (> 180 Días)" => "20",
    "21 (Incobrable)" => "21"}

  has_one :cliente, through: :cliente_persona
  has_one :persona_natural, through: :cliente_persona
  has_one :persona_juridica, through: :cliente_persona

  has_one :cliente_persona, primary_key: 'id_cliente_persona', foreign_key: "id_cliente_persona"

  scope :cantidad_de_creditos_por_cliente, ->(cli){joins(:cliente_persona).where(:clientes_personas => {:id_cliente => cli}).count}

  # attr_accessor :cedula, :nombre, :apellido

  # validates_presence_of :cliente
  # validates_presence_of :persona_natural
  validates :cliente_persona, presence: true
  validates :factura, :fecha_compra, :fecha_operacion, :monto, :pago_mes, :num_giros, :experiencia, :estado, presence: true
  validates :num_giros, :experiencia, :estado, numericality: { only_integer: true }
  validates :monto, :pago_mes, numericality: { :greater_than => 0.0 }


  accepts_nested_attributes_for :cliente_persona
  accepts_nested_attributes_for :persona_natural

  def es_natural?
    persona_juridica.nil?
  end

  def es_juridica?
    persona_natural.nil?
  end

  def estado_humanizado
    estado == 1 ? "Cancelado" : "Activo"
  end
end

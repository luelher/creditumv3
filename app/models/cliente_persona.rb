class ClientePersona < ActiveRecord::Base
	self.table_name = 'clientes_personas'
  self.primary_key = :id_cliente_persona

  has_one :persona_juridica, primary_key: 'id_persona', foreign_key: "rif"
  has_one :persona_natural, primary_key: 'id_persona', foreign_key: "cedula"

  has_one :cliente, primary_key: 'id_cliente', foreign_key: "id_cliente"

  has_many :creditos, primary_key: 'id_cliente_persona', foreign_key: "id_cliente_persona"

  accepts_nested_attributes_for :persona_natural

  validates :persona_natural, presence: true
  validates :cliente, presence: true

end

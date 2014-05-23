class ClientePersona < ActiveRecord::Base
	self.table_name = 'clientes_personas'
  self.primary_key = :id_cliente_persona

  belongs_to :persona_juridica, primary_key: 'id_persona', foreign_key: "rif"
  belongs_to :persona_natural, primary_key: 'id_persona', foreign_key: "cedula"

  belongs_to :cliente, primary_key: 'id_cliente', foreign_key: "id_cliente"

  has_many :creditos, primary_key: 'id_cliente_persona', foreign_key: "id_cliente_persona"

end

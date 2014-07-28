class PersonaJuridica < ActiveRecord::Base
  self.table_name = 'personas_juridicas'
  self.primary_key = :rif
  #self.alias_attribute :id, :rif

  has_many :clientes_personas, primary_key: 'rif', foreign_key: "id_persona", class_name: "ClientePersona"
  has_many :clientes, through: :clientes_personas
  has_many :creditos, through: :clientes_personas
  has_many :consultas, primary_key: 'rif', foreign_key: "id_persona"
  has_many :consultas_fallidas, primary_key: 'rif', foreign_key: "id_persona"

end

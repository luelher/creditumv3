class PersonaNatural < ActiveRecord::Base
  self.table_name = 'personas_naturales'
  self.primary_key = :cedula
  self.alias_attribute :id, :cedula

  has_many :clientes_personas, primary_key: 'cedula', foreign_key: "id_persona", class_name: "ClientePersona"
  has_many :clientes, through: :clientes_personas
  has_many :creditos, through: :clientes_personas
  has_many :consultas, primary_key: 'rif', foreign_key: "id_persona"
  has_many :consultas_fallidas, primary_key: 'rif', foreign_key: "id_persona"


end

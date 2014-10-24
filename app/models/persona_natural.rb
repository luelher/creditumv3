class PersonaNatural < ActiveRecord::Base

  before_save :set_defaults

  self.table_name = 'personas_naturales'
  self.primary_key = :cedula
  self.alias_attribute :id, :cedula

  has_many :clientes_personas, primary_key: 'cedula', foreign_key: "id_persona", class_name: "ClientePersona"
  has_many :clientes, through: :clientes_personas
  has_many :creditos, through: :clientes_personas
  has_many :consultas, primary_key: 'cedula', foreign_key: "id_persona"
  has_many :consultas_fallidas, primary_key: 'cedula', foreign_key: "id_persona"

  validates :cedula, :nombre, :apellido, presence: true

  def tiene_credito_del_cliente?(cli)
    if creditos.por_casa_comercial(cli.id_casa_comercial).count > 0
      true
    else
      false
    end    
  end

  private
    def set_defaults
      if self.nacionalidad.to_s.empty?
        self.nacionalidad = "VENEZOLANO"
      end
    end


end

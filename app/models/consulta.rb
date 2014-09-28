class Consulta < ActiveRecord::Base
  self.table_name = 'consultas'

  belongs_to :cliente, primary_key: 'id_cliente', foreign_key: "id_cliente"
  belongs_to :persona_juridica, primary_key: 'id_persona', foreign_key: "rif"
  belongs_to :persona_natural, primary_key: 'id_persona', foreign_key: "cedula"
  has_one :usuario, primary_key: 'cedula_usuario', foreign_key: "cedula"
  # belongs_to :user

  scope :por_cliente, ->(cli) {where(:id_cliente => cli)}

  def self.procesar(persona, user)
    Consulta.create(:id_cliente => user.usuario.cliente.id, :id_persona => persona.cedula, :cedula_usuario => user.usuario.cedula.to_s, :fecha_hora => DateTime.now)
  end  

end

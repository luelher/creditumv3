class Usuario < ActiveRecord::Base
  self.table_name = 'usuarios'
  self.primary_key = :cedula

  belongs_to :cliente, primary_key: 'id_cliente', foreign_key: "id_cliente"
  belongs_to :nivel, primary_key: 'id_nivel', foreign_key: "id_nivel"
  belongs_to :consulta, primary_key: 'cedula', foreign_key: "cedula_usuario"
  belongs_to :consulta_fallida, primary_key: 'cedula', foreign_key: "cedula_usuario"  
  has_one :user, primary_key: 'cedula', foreign_key: "cedula"

  def nombre_completo
    nombre + " " + apellido
  end

  def es?(nvl)
    nvl == id_nivel
  end

end

class Usuario < ActiveRecord::Base
  self.table_name = 'usuarios'
  self.primary_key = :cedula

  attr_accessor :email
  belongs_to :cliente, primary_key: 'id_cliente', foreign_key: "id_cliente"
  belongs_to :nivel, primary_key: 'id_nivel', foreign_key: "id_nivel"
  belongs_to :consulta, primary_key: 'cedula', foreign_key: "cedula_usuario"
  belongs_to :consulta_fallida, primary_key: 'cedula', foreign_key: "cedula_usuario"  
  has_one :user, primary_key: 'cedula', foreign_key: "cedula"

  validates :cliente, presence: true
  validates :nivel, presence: true
  validates :cedula, :nombre, :apellido, :telefono, :celular, :nacionalidad, presence: true
  validates :cedula, uniqueness: true

  def nombre_completo
    nombre + " " + apellido
  end

  def email
    user.email
  end
  def es?(nvl)
    nvl == id_nivel
  end

  rails_admin do
    list do
      field :cedula
      field :nombre
      field :apellido
      field :cliente      
    end

    create do
      field :cliente do
        inline_edit false
        inline_add false
      end
      field :nombre
      field :apellido
      field :telefono
      field :celular
      field :nacionalidad
      field :nivel do
        inline_edit false
        inline_add false
      end

    end
  end

  def name
    nombre
  end

end

class CasaComercial < ActiveRecord::Base
  self.table_name = "casas_comerciales"
  self.primary_key = :id_casa_comercial
  self.alias_attribute :id, :id_casa_comercial

  has_many :clientes, foreign_key: "id_casa_comercial"

  validates :nombre, :rif, :nit, :ubicacion, presence: true


  rails_admin do
    list do
      field :nombre
      field :rif
      field :nit
      field :ubicacion      
    end

    create do
      field :nombre
      field :rif
      field :nit
      field :ubicacion
    end

  end


end

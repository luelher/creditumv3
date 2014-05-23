class CasaComercial < ActiveRecord::Base
    self.table_name = "casas_comerciales"
    self.primary_key = :id_casa_comercial
    self.alias_attribute :id, :id_casa_comercial

    has_many :clientes, foreign_key: "id_casa_comercial"

end

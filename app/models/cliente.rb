class Cliente < ActiveRecord::Base
    self.table_name = "clientes"
    self.alias_attribute :id, :id_cliente
    self.primary_key = :id_cliente

    has_one :cliente_conf, foreign_key: "id_cliente"
    belongs_to :casa_comercial, primary_key: 'id_casa_comercial', foreign_key: "id_casa_comercial"
    has_many :facturas, primary_key: 'id_cliente', foreign_key: "id_cliente"
    has_many :usuarios, primary_key: 'id_cliente', foreign_key: "id_cliente"

end

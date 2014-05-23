class ClienteConf < ActiveRecord::Base
    self.table_name = 'clientes_conf'
    self.primary_key = :id_cliente
    self.alias_attribute :id, :id_cliente

    belongs_to :cliente, foreign_key: "id_cliente"


end

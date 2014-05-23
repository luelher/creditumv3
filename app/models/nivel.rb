class Nivel < ActiveRecord::Base
    self.table_name = 'nivel'
    self.primary_key = :id_nivel

    OPERADOR_ADMINISTRADOR = 1
    OPERADOR = 2
    CONSULTOR = 3
    CONSULTOR_ADMINISTRADOR = 4

    has_one :usuario, primary_key: 'id_nivel', foreign_key: "id_nivel"

end

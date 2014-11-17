class Nivel < ActiveRecord::Base
    self.table_name = 'nivel'
    self.primary_key = :id_nivel

    OPERADOR_ADMINISTRADOR = 1  # Sr Marmol
    OPERADOR = 2                # Yuleida
    CONSULTOR = 3               # Consultor la Rana
    CONSULTOR_ADMINISTRADOR = 4 # Administrador la Rana

    has_one :usuario, primary_key: 'id_nivel', foreign_key: "id_nivel"

    def name
      descripcion
    end

end

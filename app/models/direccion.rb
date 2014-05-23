class Direccion < ActiveRecord::Base
  self.table_name = 'direcciones'
  self.primary_key = :ID_PERSONA

end

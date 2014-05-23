
# dehabilitar la funcionalidad de Mysql2Adapter de emular tipos booleanos para columnas tinyint
ActiveRecord::ConnectionAdapters::Mysql2Adapter.emulate_booleans = false

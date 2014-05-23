class AddIdToConsultas < ActiveRecord::Migration
  def change
    add_column :consultas, :id, :primary_key
    add_column :consultas_fallidas, :id, :primary_key
  end
end

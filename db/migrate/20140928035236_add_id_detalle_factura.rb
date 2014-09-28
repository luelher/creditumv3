class AddIdDetalleFactura < ActiveRecord::Migration
  def change
    add_column :detalle_facturas, :id, :primary_key
  end
end

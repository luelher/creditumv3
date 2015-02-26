class CreateClientes < ActiveRecord::Migration
  def change
    add_attachment :clientes, :logo
  end
end

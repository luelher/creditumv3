class EstadoCuentaController < ApplicationController
  authorize_resource class: EstadoCuentaController
  before_action :authenticate_user!

  def index
    current_user.usuario.cliente

    @acertadas = Consulta.por_cliente(current_user.usuario.cliente.id_cliente).order(:fecha_hora => :desc)
    @fallidas = ConsultaFallida.por_cliente(current_user.usuario.cliente.id_cliente).order(:fecha_hora => :desc)
    @ultima_factura = Factura.por_cliente(current_user.usuario.cliente.id_cliente).first

  end
end

class DetalleFacturacionController < ApplicationController
  authorize_resource class: DetalleFacturacionController
  before_action :authenticate_user!
  
  def index
    if params[:id]
      redirect_to detalle_facturacion_show_path(params[:id])
    else
      @factura = Factura.por_cliente(current_user.usuario.cliente.id).first
      if @factura
        redirect_to detalle_facturacion_show_path(@factura.id)
      else
        @factura = nil
        @facturas = Factura.where(:id_cliente => current_user.usuario.cliente.id_cliente)
        render :show
      end
    end
  end

  def show

    @facturas = Factura.por_cliente(current_user.usuario.cliente.id)

    if params[:id]
      @factura = Factura.where(:id_factura => params[:id], :id_cliente => current_user.usuario.cliente.id_cliente).first

      if @factura
        @acertadas = @factura.detalles.acertadas
        @fallidas = @factura.detalles.fallidas
        @facturas = Factura.por_cliente(current_user.usuario.cliente.id)
      else
        flash[:danger] = "La Factura No existe"
      end

    else

    end

  end

end

class ClientesController < ApplicationController
  before_action :set_cliente

  # GET /clientes
  def index
    redirect_to edit_cliente_path(@cliente)
  end

  # PATCH/PUT /clientes/1
  def update
    if @cliente.update(cliente_params)
      redirect_to edit_cliente_path(@cliente), notice: 'Sus datos fueron actualizados Satisfactoriamente.'
    else
      render action: 'edit'
    end
  end

  # GET /clientes/1/edit
  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(current_user.usuario.cliente.id)
    end

    # Only allow a trusted parameter "white list" through.
    def cliente_params
      params.require(:cliente).permit(:direccion, :telefono, :fax, :celular, :email, :logo)
    end
end

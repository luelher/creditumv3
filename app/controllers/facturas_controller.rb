class FacturasController < ApplicationController
  before_action :set_factura, only: [:show, :edit, :update, :destroy]

  # GET /facturas
  def index
    @facturas = Factura.all.includes(:cliente => :casa_comercial).order(fecha_hasta: :desc)
  end

  # GET /facturas/1
  def show
  end

  # GET /facturas/new
  def new
    @factura = Factura.new
  end

  # GET /facturas/1/edit
  def edit
  end

  # POST /facturas
  def create
    @factura = Factura.new(factura_params)

    validas = Consulta.where("fecha_hora >= ? and fecha_hora <= ? and id_cliente = ?", @factura.fecha_desde, @factura.fecha_hasta, @factura.id_cliente)
    fallidas = ConsultaFallida.where("fecha_hora >= ? and fecha_hora <= ? and id_cliente = ?", @factura.fecha_desde, @factura.fecha_hasta, @factura.id_cliente) 

    @factura.validas = validas.count
    @factura.fallidas = fallidas.count

    validas.each do |v|
      @factura.detalles.push(DetalleFactura.new(cedula_usuario: v.cedula_usuario, id_persona: v.id_persona, fecha_hora: v.fecha_hora, status: 1))
    end

    fallidas.each do |f|
      @factura.detalles.push(DetalleFactura.new(cedula_usuario: f.cedula_usuario, id_persona: f.id_persona, fecha_hora: f.fecha_hora, status: 0))
    end

    if @factura.save
      Consulta.delete_all(["fecha_hora >= ? and fecha_hora <= ? and id_cliente = ?", @factura.fecha_desde, @factura.fecha_hasta, @factura.id_cliente])
      ConsultaFallida.delete_all(["fecha_hora >= ? and fecha_hora <= ? and id_cliente = ?", @factura.fecha_desde, @factura.fecha_hasta, @factura.id_cliente])
      redirect_to :index, notice: 'La Factura fue Creada Satisfactoriamente.'
    else
      puts @factura.errors.to_json
      render action: 'new'
    end
  end

  # PATCH/PUT /facturas/1
  def update
    if @factura.update(factura_params)
      redirect_to @factura, notice: 'La Factura fue Actualizada Satisfactoriamente.'
    else
      render action: 'edit'
    end
  end

  # DELETE /facturas/1
  def destroy
    @factura.destroy
    redirect_to facturas_url, notice: 'La Factura fue Eliminada Satisfactoriamente..'
  end

  def buscar
    cliente = params[:cliente]
    desde = params[:desde]
    hasta = params[:hasta]
    unless desde.to_s=='' or hasta.to_s==''
      render json: {
        validas: Consulta.where("fecha_hora >= ? and fecha_hora <= ? and id_cliente = ?", desde.to_datetime, hasta.to_datetime, cliente).count,
        fallidas: ConsultaFallida.where("fecha_hora >= ? and fecha_hora <= ? and id_cliente = ?", desde.to_datetime, hasta.to_datetime, cliente).count,
      }
    else
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_factura
      @factura = Factura.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def factura_params
      params.require(:factura).permit(:id_cliente, :fecha_desde, :fecha_hasta, :validas, :fallidas)
    end
end

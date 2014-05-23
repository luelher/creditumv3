class AsistenciaTelefonicaController < ApplicationController
  authorize_resource class: AsistenciaTelefonicaController
  before_action :authenticate_user!

  def index
  end

  def search_users
    if params[:casa_comercial]
      @usuarios = Usuario.joins(:cliente).where("clientes.id_casa_comercial = ?",params[:casa_comercial])
    else
      @usuarios = nil
    end
  end

  def search

    if params[:cedula] && params[:casa_comercial] && params[:usuario]
      @persona = PersonaNatural.find_by_cedula params[:cedula]
      @persona = PersonaJuridica.find_by_rif params[:cedula] if @persona.nil?
      @usuario = User.find_by_cedula(params[:usuario])

      if @persona && @usuario
        Consulta::procesar(@persona, @usuario)
      else
        ConsultaFallida::procesar(params[:cedula], @usuario) if @usuario
      end
    else
      @persona = nil
    end
  end

end

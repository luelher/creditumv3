class InformacionCrediticiaController < ApplicationController
  authorize_resource class: InformacionCrediticiaController
  before_action :authenticate_user!


  def index
  end

  def search
    if params[:cedula]
      @persona = PersonaNatural.find_by_cedula params[:cedula]
      @persona = PersonaJuridica.find_by_rif params[:cedula] if @persona.nil?

      if @persona
        Consulta::procesar(@persona, current_user)
      else
        ConsultaFallida::procesar(params[:cedula], current_user)
      end
      flash[:success] = "Persona Encontrada"
    else
      flash[:danger] = "Debe ingresar la cédula a buscar"
      @persona = nil      
    end
  end

end

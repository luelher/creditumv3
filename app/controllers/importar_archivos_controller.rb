class ImportarArchivosController < ApplicationController
  authorize_resource class: ImportarArchivosController
  before_action :authenticate_user!

  def index

  end

  def import
    uploaded_io = params[:archivo]
    cliente = current_user.usuario.id_cliente
    archivo = cliente.to_s+"_"+DateTime.now.strftime("%Y%m%d%H%M")+"_"+uploaded_io.original_filename
    file = File.open(Rails.root.join('uploads', archivo), 'wb')
    file.write(uploaded_io.read)
    
    tipo = params[:tipo]
    if tipo == '0'
      generica = Generica.new
      generica.archivo = archivo
      @procesados = generica.importar
    else
      @procesados = [0,0]
    end
  end
end
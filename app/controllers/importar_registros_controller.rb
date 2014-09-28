class ImportarRegistrosController < ApplicationController
  authorize_resource class: ImportarRegistrosController
  before_action :authenticate_user!


  def index
    cre = Credito.new
    cre.cliente_persona = ClientePersona.new
    cre.cliente_persona.persona_natural = PersonaNatural.new
    @creditos = [cre, cre, cre, cre, cre]
  end

  def import

    creditos_params = params[:credito]

    @creditos = Array.new

    creditos_params.each do |k, v|
      
      if !v["id"].empty?
        cre = Credito.find(v["id"])
        if v["experiencia"].to_i > cre.experiencia
          cre.factura = v["factura"]
          cre.fecha_compra = v["fecha_compra"]
          cre.pago_mes = v["pago_mes"]
          cre.num_giros = v["num_giros"]
          cre.monto = v["monto"]
          cre.experiencia = v["experiencia"]
        end
      else
        cre = Credito.new(v)
        cre.estado = 0
        cre.cliente_persona.cliente = current_user.usuario.cliente
        pn = PersonaNatural.find v["cliente_persona_attributes"]["persona_natural_attributes"]["cedula"]
        if pn
          cre.cliente_persona.persona_natural = pn
        end
        cre.cliente_persona.persona_natural.cedula = v["cliente_persona_attributes"]["persona_natural_attributes"]["cedula"]
      end
      cre.fecha_operacion = Date.today
      @creditos.push cre

    end

    @creditos.each do |credito|
      unless credito.cliente_persona.persona_natural.cedula.to_s.empty?
        unless credito.valid?
          flash[:danger] = credito.errors.full_messages.map{|e| "<p>"+e+"</p>"}.unshift("Ocurrieron algunos errores al importar los datos").join
          render :index and return
        end
      end
    end

    @guardados = 0
    @creditos.each do |credito|
      unless credito.cliente_persona.persona_natural.nombre.to_s.empty?
        if credito.new_record?
          flash[:danger] = ""
          unless credito.cliente_persona.persona_natural.save
            flash[:danger] += credito.cliente_persona.persona_natural.errors.full_messages.join
          end
          credito.cliente_persona.id_persona = credito.cliente_persona.persona_natural.cedula
          credito.cliente_persona.id_cliente = current_user.usuario.id_cliente

          unless credito.cliente_persona.save
            flash[:danger] += credito.cliente_persona.errors.full_messages.join
          end
          credito.id_cliente_persona = credito.cliente_persona.id_cliente_persona
          if credito.save
            @guardados += 1
          else
            flash[:danger] += credito.errors.full_messages.join
          end
        else 
          if credito.save
            @guardados += 1
          end
        end
      end
    end

    flash[:success] = "Información Importada Correctamente"
    # flash[:danger] = "Ocurrieron algunos errores al importar los datos"
  end

  def search_personas
    if params[:cedula] && params[:cedula_name]
      @name_nombre = params[:cedula_name].gsub("cedula", "nombre")
      @name_apellido = params[:cedula_name].gsub("cedula", "apellido")
      @name_id_cliente_persona = params[:cedula_name].gsub("persona_natural_attributes][cedula", "id_cliente_persona");
      @name_factura = params[:cedula_name].gsub("cliente_persona_attributes][persona_natural_attributes][cedula", "factura");

      @persona = PersonaNatural.where("cedula like '%#{params[:cedula]}'").first
      @persona = PersonaJuridica.where("rif like '%#{params[:cedula]}'") if @persona.nil?
      if @persona
        @cliente_persona = ClientePersona.where(:id_persona => @persona.id, :id_cliente => current_user.usuario.cliente.id_cliente).first
      else
        @cliente_persona = nil
      end
    else
      @persona = nil
      @cliente_persona = nil
    end
  end

  def search_facturas
    if params[:id_cliente_persona] && params[:factura_name] && params[:factura]
      puts "entro"
      @name_fecha_compra = params[:factura_name].gsub("factura", "fecha_compra")
      @name_pago_mes = params[:factura_name].gsub("factura", "pago_mes")
      @name_num_giros = params[:factura_name].gsub("factura", "num_giros")
      @name_monto = params[:factura_name].gsub("factura", "monto")
      @name_experiencia = params[:factura_name].gsub("factura", "experiencia")
      @name_id = params[:factura_name].gsub("factura", "id")

      @credito = Credito.where(:id_cliente_persona => params[:id_cliente_persona], :factura => params[:factura]).first
    else
      @credito = nil
    end
  end


end

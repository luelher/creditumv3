class Generica
  attr_accessor :archivo, :cliente

  def importar
    procesados = 0
    errores = 0
    File.readlines(Rails.root.join('uploads', archivo)).each do |line|
      tokens = line_parsing(line)
      puts tokens.to_json
      if tokens
        if tokens_processing(tokens) 
          procesados += 1
        else
          errores += 1
        end
      else
        errores += 1
      end
    end

    # Actualizar contador del cliente
    actualizar_cliente(procesados, errores)

    [procesados, errores]
  end

  private

  def line_parsing(line)
    parts = line.chomp.split("\t")
    if parts.count > 4
      if parts.count == 11
        { 
          :cedula => parts[0].strip,
          :nombre => parts[1].strip,
          :apellido => "",
          :telefono => parts[2].strip,
          :celular => parts[3].strip,
          :profesion => "",
          :factura => parts[4].strip,
          :fecha_compra => parts[5].to_s.to_date,
          :monto => parts[6].to_f,
          :pago_mes => parts[7].to_f,
          :numero_giros => parts[8].to_i,
          :fecha_cancelacion => parts[9].to_s.empty? ? "2001-01-01".to_date : parts[9].to_s.to_date,
          :experiencia => parts[12].to_i
        }
      else
        { 
          :cedula => parts[0].strip,
          :nombre => parts[1].strip,
          :apellido => parts[2].strip,
          :telefono => parts[3].strip,
          :celular => parts[4].strip,
          :profesion => parts[5].strip,
          :factura => parts[6].strip,
          :fecha_compra => parts[7].to_s.to_date,
          :monto => parts[8].to_f,
          :pago_mes => parts[9].to_f,
          :numero_giros => parts[10].to_i,
          :fecha_cancelacion => parts[11].to_s.empty? ? "2001-01-01".to_date : parts[11].to_s.to_date,
          :experiencia => parts[12].to_i
        }
      end
    else
      nil
    end
  end

  def tokens_processing(tokens)

    unless tokens.nil?
      id_cliente_persona = nil
      # Verificar si el cliente es natural o juridico
      if tokens[:cedula].to_s.first.upcase == "J"
        # Juridico
        id_cliente_persona = verificar_juridico(tokens)
      else
        # Natural
        id_cliente_persona = verificar_natural(tokens)
      end

      if id_cliente_persona
        # Procesar al actualización/inserción
        if revisar_registro(tokens, id_cliente_persona)
          true
        else
          false
        end
      end    

      true
    else
      false
    end

  end

  def verificar_natural(t)
    persona_natural = PersonaNatural.find_by_cedula(t[:cedula])
    if persona_natural
      cliente_persona = ClientePersona.joins(:personas_naturales).where(:id_cliente => cliente, :persona_natural => {:cedula => t[:cedula]}).first
      unless cliente_persona
        cliente_persona = ClientePersona.new(:id_persona => t[:cedula], :id_cliente => cliente)
        cliente_persona.save
        cliente_persona
      else
        cliente_persona.id_cliente_persona
      end      
    else
      persona_natural = PersonaNatural.new(:cedula => t[:cedula], :nombre => t[:nombre], :apellido => t[:apellido], :telefono => t[:telefono])
      persona_natural.clientes_personas << ClientePersona.new(:id_cliente => cliente)
      persona_natural.save
      persona_natural.clientes_personas.first.id_cliente_persona
    end
  end

  def verificar_juridico(t)
    persona_juridica = PersonaJuridica.find_by_rif(t[:cedula])
    if persona_juridica
      cliente_persona = PersonaJuridica.joins(:clientes_personas).where(:rif => t[:cedula], :clientes_personas => {:id_cliente => cliente}).first
      unless cliente_persona
        cliente_persona = ClientePersona.new(:id_persona => t[:cedula], :id_cliente => cliente)
        cliente_persona.save()
      end
      cliente_persona.id_cliente_persona
    else
      persona_juridica = PersonaJuridica.new(:rif => t[:cedula], :nombre => t[:nombre], :telefono => t[:telefono])
      persona_juridica.clientes_personas << ClientePersona.new(:id_cliente => cliente)
      persona_juridica.save
      persona_juridica.clientes_personas.first.id_cliente_persona
    end
  end

  def revisar_registro(t, id_cliente_persona)
    begin
      # Buscar Credito
      credito = Credito.where(:id_cliente_persona => id_cliente_persona, :factura => t[:factura], :fecha_compra => t[:fecha_compra])

      if ( (t[:fecha_cancelacion]=="2001-01-01".to_date) || (t[:fecha_cancelacion].year < 2002) ) 
        estado=0
      else 
        estado=1
      end

      if credito
        credito.monto = t[:monto]
        credito.pago_mes = t[:pago_mes]
        credito.fecha_compra = t[:fecha_compra]
        credito.num_giros = t[:num_giros]
        credito.estado = estado
        if(estado==0)
          # Existe pero NO esta cancelado
          credito.fecha_operacion = Date.today
        else
          # Existe y esta cancelado
          credito.fecha_operacion = t[:fecha_cancelacion]
        end

        if(t[:experiencia] > credito.experiencia)
          credito.experiencia = t[:experiencia]
        end
      else
          credito = new Creditos();
    
          credito.id_cliente_persona = id_cliente_persona
          credito.factura = t[:factura]
          credito.fecha_compra = t[:fecha_compra]
          credito.monto = t[:monto]
          credito.pag_mes = t[:pag_mes]
          credito.num_giros = t[:num_giros]
          if(estado==0)
            # Existe pero NO esta cancelado
            credito.fecha_operacion = Date.today
          else
            # Existe y esta cancelado
            credito.fecha_operacion = t[:fecha_cancelacion]
          end
          credito.experiencia = t[:experiencia];
      end
      credito.save
    rescue Exception => e
      false
    end
  end

  def actualizar_cliente(procesados, errores)
    logger = Logger.new('log/importado.log')
    begin
      clientesconf = ClienteConf.where(:id_cliente, cliente);

      if clientesconf

        clientesconf.suma += procesados;
        
        clientesconf.save();

        logger.info "#{DateTime.now.to_s} - Cliente (#{clientesconf.id_cliente}): #{clientesconf.cliente.casa_comercial.nombre} - #{clientesconf.cliente.nombre}"
        logger.info "#{DateTime.now.to_s} - Cliente (#{clientesconf.id_cliente}): procesados=#{procesados}, errores=#{errores}"                
      else
        logger.info "#{DateTime.now.to_s} - Cliente (#{cliente}): No existe el Cliente"
        logger.info "#{DateTime.now.to_s} - Cliente (#{cliente}): procesados=#{procesados}, errores=#{errores}"
      end
      true
    rescue Exception => e
      false
    end
  end

end
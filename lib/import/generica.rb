class Generica
  attr_accessor :archivo, :cliente

  def importar
    procesados = 0
    errores = 0
    File.readlines(Rails.root.join('uploads', archivo)).each do |line|
      tokens = line_parsing(line)
      puts tokens.to_json
      unless tokens
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
    actualizar_cliente(procesados)

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
  end

  def verificar_natural(t)
    persona_natural = PersonaNatural.find_by_cedula(t[:cedula])
    if persona_natural
      cliente_persona = PersonaNatural.joins(:clientes_personas).where(:rif => t[:cedula], :clientes_personas => {:id_cliente => cliente}).first
      unless cliente_persona
        cliente_persona = ClientesPersonas.new(:id_persona => t[:cedula], :id_cliente => cliente)
        cliente_persona.save()
      end
      cliente_persona.id_cliente_persona
    else
      persona_natural = PersonaNatural.new(:cedula => t[:cedula], :nombre => t[:nombre], :apellido => t[:apellido], :telefono => t[:telefono])
      persona_natural.clientes_personas << ClientesPersonas.new(:id_cliente => cliente)
      persona_natural.save
      persona_natural.clientes_personas.first.id_cliente_persona
    end
  end

  def verificar_juridico(t)
    persona_juridica = PersonaJuridica.find_by_rif(t[:cedula])
    if persona_juridica
      cliente_persona = PersonaJuridica.joins(:clientes_personas).where(:rif => t[:cedula], :clientes_personas => {:id_cliente => cliente}).first
      unless cliente_persona
        cliente_persona = ClientesPersonas.new(:id_persona => t[:cedula], :id_cliente => cliente)
        cliente_persona.save()
      end
      cliente_persona.id_cliente_persona
    else
      persona_juridica = PersonaJuridica.new(:rif => t[:cedula], :nombre => t[:nombre], :telefono => t[:telefono])
      persona_juridica.clientes_personas << ClientesPersonas.new(:id_cliente => cliente)
      persona_juridica.save
      persona_juridica.clientes_personas.first.id_cliente_persona
    end
  end

  def revisar_registro(t, id_cliente_persona)

    # Buscar Credito
    credito = Credito.where(:id_cliente_persona => id_cliente_persona, :factura => t[:factura], :fecha_compra => t[:fecha_compra])

    if credito
    end


  end

  def actualizar_cliente(procesados)

  end

end
class Generica
  attr_accessor :archivo, :cliente

  def importar
    procesados = 0
    errores = 0
    File.readlines(Rails.root.join('uploads', archivo)).each do |line|
      tokents = line.chomp.split("\t")
      puts tokents.to_json
      procesados += 1
    end

    [procesados, errores]
  end

end
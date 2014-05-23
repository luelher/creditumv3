class Credito < ActiveRecord::Base

  has_one :cliente, through: :cliente_persona
  has_one :persona_natural, through: :cliente_persona
  has_one :persona_juridica, through: :cliente_persona

  belongs_to :cliente_persona, primary_key: 'id_cliente_persona', foreign_key: "id_cliente_persona"


  def es_natural?
    persona_juridica.nil?
  end

  def es_juridica?
    persona_natural.nil?
  end
end

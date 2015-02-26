class Cliente < ActiveRecord::Base
    self.table_name = "clientes"
    #self.alias_attribute :id, :id_cliente
    self.primary_key = :id_cliente

    has_attached_file :logo, :default_url => "/images/:logos/missing.png"
    validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

    has_one :cliente_conf, foreign_key: "id_cliente"
    belongs_to :casa_comercial, primary_key: 'id_casa_comercial', foreign_key: "id_casa_comercial"
    has_many :facturas, primary_key: 'id_cliente', foreign_key: "id_cliente"
    has_many :usuarios, primary_key: 'id_cliente', foreign_key: "id_cliente"

    validates :casa_comercial, presence: true
    validates :nombre, :rif, :nit, :direccion, :telefono, :celular, :email, presence: true


    def nombre_con_casa_comercial
      unless casa_comercial.nil?
        "#{casa_comercial.nombre} - #{nombre} (#{id})"
      else
        "#{nombre} (#{id})"
      end
    end

    def name
      nombre
    end

  rails_admin do
    list do
      field :nombre
      field :rif
      field :nit
      field :direccion
      field :casa_comercial
    end

    create do
      field :nombre
      field :rif
      field :nit
      field :direccion
      field :telefono
      field :fax
      field :celular
      field :email
      field :casa_comercial do
        inline_edit false
        inline_add false
      end

    end
  end


end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :trackable, :validatable, :registerable

  validates :username,
    :uniqueness => {
      :case_sensitive => false
    }

  belongs_to :usuario, primary_key: 'cedula', foreign_key: "cedula"

  def es?(nvl)
    usuario.es?(nvl) unless usuario.nil?
  end

  def name
    email
  end

end

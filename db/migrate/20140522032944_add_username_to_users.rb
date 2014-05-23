class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :cedula, :integer
    add_index :users, :cedula, unique: true

    Usuario.all.each do |u|
      user = User.new(:email => u.cedula.to_s + "@creditum.net", :password => "creditum123", :username => u.cedula.to_s, :cedula => u.cedula)
      unless user.save
        puts user.errors.messages
      end
    end

  end
end

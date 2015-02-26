class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]

  # GET /usuarios
  def index
    @usuarios = Usuario.where(id_cliente: current_user.usuario.id_cliente)
  end

  # GET /usuarios/1
  def show
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
  end

  # POST /usuarios
  def create
    @usuario = Usuario.new(usuario_params)
    @usuario.id_cliente = current_user.usuario.id_cliente
    @usuario.pwd = Digest::MD5.hexdigest(params[:usuario][:password])
    @usuario.user = User.new
    @usuario.user.email = params[:usuario][:email]
    @usuario.user.password = params[:usuario][:password]
    @usuario.user.password_confirmation = params[:usuario][:confirm_password]
    @usuario.user.username = @usuario.cedula

    if @usuario.save
      redirect_to usuarios_path, notice: 'El Usuario fue satisfactoriamente creado.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /usuarios/1
  def update
    @usuario.id_cliente = current_user.usuario.id_cliente
    @usuario.user.email = params[:usuario][:email]
    @usuario.user.password = params[:usuario][:password]
    @usuario.user.password_confirmation = params[:usuario][:confirm_password]
    if @usuario.update(usuario_params)
      redirect_to usuarios_path, notice: 'El Usuario fue satisfactoriamente actualizado.'
    else
      render action: 'edit'
    end
  end

  # DELETE /usuarios/1
  def destroy
    @usuario.destroy
    redirect_to usuarios_url, notice: 'El Usuario fue satisfactoriamente destruido.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.where(id_cliente: current_user.usuario.id_cliente, cedula: params[:id]).first
    end

    # Only allow a trusted parameter "white list" through.
    def usuario_params
      params.require(:usuario).permit(:cedula, :nombre, :apellido, :telefono, :celular, :id_nivel)
    end
end

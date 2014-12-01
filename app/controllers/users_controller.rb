class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :authenticate_manager, :can_execute

  def index
    @users = User.all
    respond_to do |format|
      format.html # new.html.erb
    end
  end
 # vista nuevo usuario
  def new
    @user = User.new
=begin
    if current_user.isAdmin
        @roles = Rol.all
    else
       @roles = Rol.rolesNoAdmin
    end
    @dependencias = Dependencia.where(:organismo_id => Organismo::ID_FCEFQyN)
=end
    prepare_roles_dependencias
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  #POST new user
  def create
     @user = User.new(user_params_new)
     if @user.save
        redirect_to users_path, :notice => "Usuario Creado!!!"
     else
        prepare_roles_dependencias
        render "new"
     end
  end

  # GET /user/1/edit
  def edit
    @user = User.find(params[:id])
    prepare_roles_dependencias
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @params= user_params_new #params.require(:user).permit(:username, :email, :rol_id)
    respond_to do |format|
      if @user.update_attributes(@params)
        format.html { redirect_to  users_path, notice: 'El Usuario se actualizo correctamente.' }
        format.json { head :no_content }
      else
        format.html {
          prepare_roles_dependencias
          render action: "edit"
        }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end



   # GET /user/1/editpwd
  def editpwd
    @user = User.find(params[:id])
  end

  def updatepwd
      @user = User.find(params[:id])
      @user.reset_password_token = 'temp'
      @user.save!
      respond_to do |format|
          if @user.reset_password!(params[:user][:password], params[:user][:password_confirmation])
              format.html { redirect_to users_path, notice: 'Se actualizo correctamente el password del usuario.' }
              format.json { head :no_content }
          else
              format.html { render action: "editpwd" }
              format.json { render json: @user.errors, status: :unprocessable_entity }
          end
      end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'Se elimino el usuario.'}
      format.json { head :no_content }
    end
  end

protected
    def prepare_roles_dependencias
        @dependencias = Dependencia.where(:organismo_id => Organismo::ID_FCEFQyN)
        if current_user.isAdmin
            @roles = Rol.all
        else
           @roles = Rol.rolesNoAdmin
        end
    end
private
    def user_params_new
      params.require(:user).permit(:username, :password, :email, :rol_id, :dependencia_id)
    end
    def can_execute
          #["index","new","show","edit","create","update","destroy"]
          if current_user.isSecAdm
              if ["index","new","show"].include?(params[:action])
                  return true
              elsif ["edit","update","destroy","editpwd", "updatepwd"].include?(params[:action])
                  @user = User.find(params[:id])
                  if @user.isAdmin
                      flash[:error] = "No tiene permisos suficientes para ejecutar "+params[:action]
                      redirect_to root_path # halts request cycle
                  else
                      return true
                  end
              elsif "create" == params[:action]
                  if(params[:rol_id == Rol::ROL_ADMIN])
                       flash[:error] = "No tiene permisos suficientes para ejecutar "+params[:action]
                       redirect_to root_path # halts request cycle
                  else
                      return true
                  end
              else
                  flash[:error] = "No tiene permisos suficientes para ejecutar "+params[:action]
                  redirect_to root_path # halts request cycle
              end
          else
              return true
          end
    end
end

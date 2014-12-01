class ProfileController < ApplicationController
  # vista editar mi usuario
  def index
    self.edit
  end
  def edit
      @user= current_user
      if @user
        respond_to do |format|
            #format.html # edit.html.erb
            format.html { render action: "edit" }

        end
      else
         redirect_to root_url
      end
  end
  # accion modificar profile
  def update
      @user= current_user
      if @user
          valid_update_params = {:email=>params[:user][:email]}
          respond_to do |format|
              if @user.update_attributes(valid_update_params)
                  format.html { redirect_to root_url, notice: 'Perfil modificado correctamente.' }
                  format.json { head :no_content }
              else
                  format.html { render action: "edit" }
                  format.json { render json: @user.errors, status: :unprocessable_entity }
              end
          end

      end
  end
  # vista cambiar mi contraseña
  def password
    @user= current_user
    respond_to do |format|
      format.html # password.html.erb
    end
  end

# accion cambiar password
  def update_password
      @current_user= current_user
      error=false
      if params[:password] != params[:password_confirmation] then
          flash[:error] = "La Contraseña y la Confirmacion no coinciden"
          error=true
      end
      @user = User.authenticate(@current_user.username,params[:current_password])

      if !error && !@user.nil? then
        @params=params.permit(:password)

          if  @user.update_attributes(@params)
            flash[:notice] = "La Contraseña actual es incorrecta"
          else
              flash[:error] = "Error al guardar la Contraseña"
              error=true
          end
      else
        if @user.nil? then flash[:error] = "La contraseña anterior no es correcta" end
        error=true
      end

      respond_to do |format|
        format.html{
          if !error
              redirect_to root_url, notice: 'Contraseña modificada!!!'
          else
              redirect_to profile_password_path
          end
       }
      end
  end

end

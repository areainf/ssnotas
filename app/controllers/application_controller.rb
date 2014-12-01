class ApplicationController < ActionController::Base
  layout :set_layout
  protect_from_forgery
  ###USER OLD before_action :require_login, :term_search
  before_action :term_search
  before_action :setPaginateDefault

  #helper_method :current_user, :is_current_user_admin, :is_current_user_sec_adm,:prepare_query
  #### Comentado temporalmente restaurara para que un usuario no activo se autodesloguee  efore_filter :session_expires, :except => [:log_in, :log_out]
  #### Comentado temporalmente restaurara para que un usuario no activo se autodesloguee before_filter :update_session_time, :except => [:log_in, :log_out]

  def info_for_paper_trail
    @user=current_user
    if @user.nil?
      @id_user = -2
    else
      @id_user = @user.id
    end
    { :ip => request.remote_ip, :user_agent => request.user_agent, :user_id => @id_user }
  end

  def user_for_paper_trail
    current_user
  end

  def authenticate_admin
      if !user_signed_in? || !current_user.isAdmin
        redirect_to root_path , notice: "No tiene permiso administrativo!!!"
      end
  end
  def authenticate_secAdm
      if !user_signed_in? || !current_user.isSecAdm
        redirect_to root_path , notice: "No tiene permiso administrativo!!!"
      end
  end
  def authenticate_manager
      if !user_signed_in? || !(current_user.isSecAdm  || current_user.isAdmin)
        redirect_to root_path , notice: "No tiene permiso administrativo!!!"
      end
  end
  def authenticate_secDep
      if !user_signed_in? || !current_user.isSecDep
        redirect_to root_path , notice: "No tiene permiso administrativo!!!"
      end
  end
protected
  def set_layout
    if user_signed_in?
      "application"
    else
      "welcome"
    end
  end
  private

    def mobile_device?
      request.user_agent =~ /Mobile|webOS/
    end
    helper_method :mobile_device?


    def current_userMNM
      if @current_user.nil?
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      else
        @current_user
      end
    end

    def require_loginMNM
      if !session[:user_id]
        flash[:error] = "Debe estar logueado en el sistema"
        redirect_to :log_in # halts request cycle
      end
   end

   def is_current_user_admin
    user = current_user
    if user
      user.isAdmin
    else
      return false
    end
   end
   def is_current_user_sec_adm
    user = current_user
    if user
      user.isSecAdm
    else
      return false
    end
   end
   def is_current_user_sec_dep
      user = current_user
      if user
        user.isSecDep
      else
        return false
      end
    end

  def term_search
      #cuando se realiza una busqueda y luego una ordenacion, la ordenacion se hace sobre todo los elementos
      # y no sobre la busqueda, entonces se va a setear en la sesion si esta la busqueda para que solo se ordene eso
      #if(params[:search])
      #    session[:search] = params[:search]
      #else
      #    session[:search] = nil
      #end
      if(params[:action]=="search" || params[:sort])
        if(params[:term])
            session[:term] = params[:term]
        end
      else
          if session[:term]
            session[:term] = nil
          end
      #else
      #    session[:term] = nil
      end
  end


  def session_expires
    if ! session[:expires_at].nil?
        @time_left = (session[:expires_at] - Time.now).to_i
        unless @time_left > 0
          reset_session
          flash[:error] = 'Expiro la Sesión.'
          #redirect_to log_in #:controller => 'foo', :action => 'bar'
          redirect_to :log_in
        end
     end
  end

  def update_session_time
    session[:expires_at] = 1.hours.from_now
  end

  #
  # Lo uso porque consulto todo con paginate
  # y si rows = "" no muestra nada
  # asi me aseguro que siempre este correctamente definido page y rows
  # necesarios para el funcionamiento de paginate
  #
  def setPaginateDefault
      if defined?(params[:page])
        if params[:page].blank?
            params[:page] = 1
        end
      else
            params[:page] = 1
      end
      if defined?(params[:rows])
        if params[:rows].blank?
            params[:rows] = 30
        end
      else
            params[:rows] = 30
      end
  end

end

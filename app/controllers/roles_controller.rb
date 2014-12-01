class RolesController < ApplicationController
  before_action :set_rol, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :authenticate_admin
  # GET /roles
  def index
    @roles = Rol.all
  end

  # GET /roles/1
  def show
  end

  # GET /roles/new
  def new
    @rol = Rol.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  def create
    @rol = Rol.new(rol_params)

    if @rol.save
      redirect_to @rol, notice: 'Rol was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /roles/1
  def update
    if @rol.update(rol_params)
      redirect_to @rol, notice: 'Rol was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /roles/1
  def destroy
    @rol.destroy
    redirect_to roles_url, notice: 'Rol was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rol
      @rol = Rol.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rol_params
      params.require(:rol).permit(:name, :description)
    end
end

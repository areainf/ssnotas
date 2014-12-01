class VersionsController < ApplicationController
  #reify es el modelo a restarar (Dependencia, Nota, Persona, etc)
  def revert
    @version = Version.find(params[:id])
    @version.reify.save!
    redirect_to :back, :notice => "Undid #{@version.event}"
  end

end

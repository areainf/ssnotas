class NotaPersonaController < ApplicationController
	before_filter :authenticate_user!
	before_action :authenticate_manager
	respond_to :json
	def create
		@nota_persona = NotaPersona.new(params)
	    if @nota_persona.save
	    	render json: @nota_persona, status: :created
	    else
	    	render json: @nota_persona.errors, status: :unprocessable_entity
	    end
	end
	def delete
		@nota_persona = NotaPersona.where({:nota_id => params[:nota_id], :persona_id =>params[:persona_id]}).first
 		@nota_persona.destroy
 		flash[:message]='Se ha eliminado a la Persona.'
 		render json: @nota_persona, status: :created
	end
end

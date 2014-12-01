class NotasAttachmentController < ApplicationController
  respond_to :html, :json

  before_action :set_nota_attachment, only: [:show, :edit, :update, :destroy]

  # GET /notas_attachment
  # def index
  #   @notas_attachment = NotaAttachment.all
  # end

  # GET /notas_attachment/1
  def show
    send_file  @nota_attachment.filescan.file.path
  end

  # # GET /notas_attachment/new
  # def new
  #   @nota_attachment = NotaAttachment.new
  # end

  # # GET /notas_attachment/1/edit
  # def edit
  # end

  # # POST /notas_attachment
  # def create
  #   @nota_attachment = NotaAttachment.new(nota_attachment_params)

  #   if @nota_attachment.save
  #     redirect_to @nota_attachment, notice: 'Nota attachment was successfully created.'
  #   else
  #     render action: 'new'
  #   end
  # end

  # # PATCH/PUT /notas_attachment/1
  # def update
  #   if @nota_attachment.update(nota_attachment_params)
  #     redirect_to @nota_attachment, notice: 'Nota attachment was successfully updated.'
  #   else
  #     render action: 'edit'
  #   end
  # end

  # DELETE /notas_attachment/1
  def destroy
    @nota_attachment.destroy
    respond_with @nota_attachment
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nota_attachment
      @nota_attachment = NotaAttachment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def nota_attachment_params
      params.require(:nota_attachment).permit(:nota_id, :filescan)
    end
end

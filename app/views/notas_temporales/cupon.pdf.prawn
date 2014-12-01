require 'prawn'

#pdf = Prawn::Document.new(:page_layout => :landscape,:skip_page_creation => true,:margin => [5,5,5,5]) do
pdf = Prawn::Document.new(:margin => [30,40,30,40]) do
    #start_new_page
    pdf.font "Helvetica"        
end
pdf.text "Fecha de carga: #{l @nota_temporal.fecha_carga}" , :size => 12, :align => :right
pdf.move_down 20
pdf.text "Facultad de Ciencias Exáctas Físico Químicas y Naturales" , :size => 18, :align => :center
pdf.move_down 20
pdf.text "Presente este cupón en mesa de entrada de la Facultad, a fin de darle entrada al Documento con codigo"
@a=store_dir_barcode(@nota_temporal.codigo)
#pdf.image "#{store_dir_barcode(#{@nota_temporal.codigo})}"
pdf.move_down 10
pdf.image "#{@a}"
pdf.text "#{@nota_temporal.codigo}"


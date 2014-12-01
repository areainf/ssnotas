class NotaAttachment < ActiveRecord::Base
	# == Atributes
  	attr_accessible :filescan, :nota_id
	mount_uploader :filescan, FileScanUploader
    belongs_to :nota

    def model_parent_id
    	nota.id
    end
end

class NotaPersona < ActiveRecord::Base
  belongs_to :persona
  belongs_to :nota
  attr_accessible :persona_id, :nota_id
  validates :persona_id, presence: true
  validates :nota_id, presence: true
end

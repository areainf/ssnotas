module PaperTrail
  class Version < ActiveRecord::Base
    attr_accessible :item_type, :item_id, :event, :whodunnit, :object, :ip, :user_agent, :user_id
  end
end

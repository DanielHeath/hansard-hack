class Speech < ActiveRecord::Base
  attr_accessible :session_talker_id, :speech
  belongs_to :session_talker
end

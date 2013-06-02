class Speech < ActiveRecord::Base
  attr_accessible :session_talker_id, :speech, :time
  belongs_to :session_talker

  default_scope :include => :session_talker, :order => 'session_talker.session_id desc, time asc'
end

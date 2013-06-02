class Speech < ActiveRecord::Base
  attr_accessible :session_talker_id, :speech, :time
  belongs_to :session_talker

  validates_presence_of :speech
  validates_presence_of :session_talker_id
  default_scope :include => :session_talker, :order => 'session_talker.session_id desc, time asc'
  delegate :name, :to => :session_talker
end

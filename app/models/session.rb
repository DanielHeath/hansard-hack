class Session < ActiveRecord::Base
  attr_accessible :chamber, :date, :parliamentno, :periodno, :sessionno
  has_many :session_talkers
  has_many :speeches, :through => :session_talkers
end

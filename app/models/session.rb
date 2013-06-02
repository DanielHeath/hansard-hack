class Session < ActiveRecord::Base
  attr_accessible :chamber, :date, :parliamentno, :periodno, :sessionno
  has_many :session_talkers
  has_many :speeches, :through => :session_talkers

  def time_from_speech_stamp(str)
  	h, m = str.split(":")
  	date.to_time + h.to_i.hours + m.to_i.minutes
  end

  def to_label
  	"#{chamber} - #{date.strftime("%d/%m/%Y")}"
  end
end

class SessionTalker < ActiveRecord::Base
  attr_accessible :electorate, :name, :nameid, :party, :session_id, :ts
  belongs_to :session
  has_many :speeches

  def parlinfo_avatar
	"<img src='http://parlinfo.aph.gov.au/parlInfo/download/handbook/allmps/#{nameid}/upload_ref_binary/#{nameid}.JPG'></img>".html_safe
  end

end

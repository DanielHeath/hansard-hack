class SessionTalker < ActiveRecord::Base
  attr_accessible :electorate, :name, :nameid, :party, :session_id, :ts
  belongs_to :session
  has_many :speeches

  def parlinfo_avatar
    "<img src='http://parlinfo.aph.gov.au/parlInfo/download/handbook/allmps/#{nameid}/upload_ref_binary/#{nameid}.JPG'></img>".html_safe
  end

  def parlinfo_link
    "<a href='#{parlinfo_url}'>parlinfo link</a>".html_safe
  end

  def parlinfo_url
    "http://parlinfo.aph.gov.au/parlInfo/search/display/display.w3p;query=%28Id:handbook/allmps/#{nameid}%29;"
  end

  def get_parlinfo
    c = `curl '#{parlinfo_url}'`
    d = Nokogiri::HTML(c)
    e = d.css(":contains('Parliamentary Service')").last
    while e = e.previous_sibling
      if e.class && e['class'] =~ /sumLink/
        self.party = e.text
      end
    end
    if not party.blank?
      SessionTalker.where(:nameid => nameid).each do |st|
        st.party = party
        st.save!
      end
    end
  end
end


 # TODO: copy nameid into speech table
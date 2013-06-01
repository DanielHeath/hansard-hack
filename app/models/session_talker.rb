class SessionTalker < ActiveRecord::Base
  attr_accessible :electorate, :name, :nameid, :party, :session_id, :ts
  belongs_to :session
  has_many :speeches
end

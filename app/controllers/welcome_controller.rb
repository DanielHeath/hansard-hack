class WelcomeController < ApplicationController
  def index
  	@foo = SessionTalker.find_by_sql "select distinct electorate from session_talkers"
  	@speakers = SessionTalker.all
  end
end

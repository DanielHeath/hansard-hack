class WelcomeController < ApplicationController
	def index
  	months = ["2011/10","2011/11","2012/2","2012/3","2012/5","2012/6","2012/8","2012/9","2012/10","2012/11","2013/2","2013/3","2013/5"]
  	@data = []
  	months.each do |month|
  	  @data << {
  	  	month: month,
  	  	gillard: Obsession.gillard.where(:yearmonth => month).order('count desc').limit(10),
  	  	abbot: Obsession.abbot.where(:yearmonth => month).order('count desc').limit(10),
  	  }
  	end
  end

end


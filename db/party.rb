
while a = SessionTalker.where(:party => nil).first
	a.get_parlinfo
end

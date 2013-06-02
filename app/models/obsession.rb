class Obsession < ActiveRecord::Base
  scope :abbot, where(:nameid => "EZ5")
  scope :gillard, where(:nameid => "83L")

  def self.fixup(old, neww)
	Obsession.where(:word => old).each do |o|
	  b = Obsession.where(:word => neww, :nameid => o.nameid, :yearmonth => o.yearmonth).first
	  if b
	    b.count += o.count
	    o.delete
	    b.save!
	  else
	    o.word = neww
	    o.save!
	  end
	end
  end


  def self.fixup_all
	Obsession.all.each do |o|
	  neww = yield o.word
	  b = Obsession.where(:word => neww, :nameid => o.nameid, :yearmonth => o.yearmonth).first
	  if b
	    b.count += o.count
	    o.delete
	    b.save!
	  else
	    o.word = neww
	    o.save!
	  end
	end
  end

end

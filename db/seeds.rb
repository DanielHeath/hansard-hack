# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Bundler.require

file = File.read('db/2013-03-20.xml'); 1
a = Nokogiri::XML(file); 1

sess = Session.new
sess.date = a.xpath("//session.header/date").text
sess.parliamentno = a.xpath("//session.header/parliament.no").text
sess.sessionno = a.xpath("//session.header/session.no").text
sess.periodno = a.xpath("//session.header/period.no").text
sess.chamber = a.xpath("//session.header/chamber").text
sess.save!

a.css("talker").each do |talker|

	speaker = SessionTalker.create!(
		:session_id => sess.id,
		:name => talker.xpath('name').text,
		:nameid => talker.xpath('name.id').text,
		:electorate => talker.xpath('electorate').text,
		:party => talker.xpath('party').text,
	)

end

a.css('a:not([href="Chamber"])').map(&:parent).each do |normal|
	speeches = normal.css('[type="MemberSpeech"]')
	raise speeches.to_xml if speeches.length > 1
	if speech = speeches.first
		timestr = speech.parent.css('.HPS-Time').text
		speaker_nameid = speech['href'].strip
		speaker = SessionTalker.find_by_nameid(speaker_nameid)
		sess_time = sess.date.to_time
		h, m = timestr.split(':')

		Speech.create!(
			:session_talker_id => speaker.id,
	      	:speech => normal.text.gsub(/[^:]*:/, '').strip,
	      	:time => sess_time + h.to_i.hours + m.to_i.minutes
		)
	end
end

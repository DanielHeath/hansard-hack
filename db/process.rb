require "bundler"
Bundler.require

class MyStylesheet < RSLT::Stylesheet

  def fallthrough(selector)
    render(selector) {child_content}
  end
  def ignore(selector)
    render(selector) {}
  end

  def rules
    ignore "page_no"
    ignore "business_start"
    ignore "debateinfo"

  	fallthrough "hansard"
    render "session_header" do
      $sess = Session.new
      child_content
      $sess.save!
    end

    render "session_header date" do
      $sess.date = text
    end
    render "session_header parliament_no" do
      $sess.parliamentno = text
    end
    render "session_header session_no" do
      $sess.sessionno = text
    end
    render "session_header period_no" do
      $sess.periodno = text
    end
    render "session_header chamber" do
      $sess.chamber = text
    end
    ignore "session_header *"


    render "talker" do
      if element.css('time_stamp').any?
        ts = element.css('time_stamp').text
        $SPEECH_TIME = $sess.time_from_speech_stamp(ts)
      end

      name = element.css('name').text
      name_id = element.css('name_id').text

      st = $sess.session_talkers.where(:nameid => name_id).first || SessionTalker.new
      st.session = $sess
      st.nameid = name_id
      st.name = name
      if element.css('electorate').any?
        st.electorate = element.css('electorate').text
      end
      st.save!
      $st = st
    end

    ["fedchamb_xscript", "chamber_xscript"].each do |script|
      fallthrough "#{script}"
      fallthrough "#{script} debate"
      within "#{script} debate" do

        fallthrough "continue"
        ["speech", "interjection"].each do |speech_type|
          fallthrough speech_type
          render "#{speech_type} para, #{speech_type} quote, #{speech_type} list" do
            $st.speeches.create!(
              :speech => text, :time => $SPEECH_TIME
            )
          end
        end

        (1..10).each do |i|
          fallthrough "subdebate_#{i}"
          within "subdebate_#{i}" do
            ignore "subdebateinfo"
            render "speech" do
            end
          end
        end

        fallthrough "division"
        within "division" do
          render "division_header" do
          end
          fallthrough "division_data"
          render "division_data ayes" do
          end
          render "division_data noes" do
          end
          render "division_data pairs" do
          end
          render "division_result" do
          end
        end

      end

    end

    render("text()") { raise element.to_xml[0..100] unless element.blank? }
  end
end

f = File.read("db/2013-03-21.xml")
x = Nokogiri::XML f

x.css("*").each do |e|
  if e.name =~ /\./
    e.name = e.name.gsub(/\./, "_")
  end
end

puts MyStylesheet.transform x

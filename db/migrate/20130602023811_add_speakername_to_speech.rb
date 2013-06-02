class AddSpeakernameToSpeech < ActiveRecord::Migration
  def up
  	add_column "speeches", "nameid", "string"
  	execute <<-SQL
  	update speeches s set nameid = (
  		select nameid from session_talkers st
  		where st.id = s.session_talker_id
  	)
  	SQL
  end
  def down
  	remove_column "speeches", "nameid"
  end
end

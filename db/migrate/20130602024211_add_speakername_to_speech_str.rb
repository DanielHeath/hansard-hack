class AddSpeakernameToSpeechStr < ActiveRecord::Migration
  def up
  	add_column "speeches", "name", "string"
  	execute <<-SQL
  	update speeches s set name = (
  		select name from session_talkers st
  		where st.nameid = s.nameid
  		order by st.id
  		limit 1
  	)
  	SQL
  end
  def down
  	remove_column "speeches", "name"
  end
end

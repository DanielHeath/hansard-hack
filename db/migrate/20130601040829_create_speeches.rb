class CreateSpeeches < ActiveRecord::Migration
  def change
    create_table :speeches do |t|
      t.integer :session_talker_id
      t.text :speech
	  t.timestamp :time
    end
  end
end

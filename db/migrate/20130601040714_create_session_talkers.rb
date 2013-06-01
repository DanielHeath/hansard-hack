class CreateSessionTalkers < ActiveRecord::Migration
  def change
    create_table :session_talkers do |t|
      t.integer :session_id
      t.timestamp :ts
      t.string :name
      t.string :nameid
      t.string :electorate
      t.string :party

      t.timestamps
    end
  end
end

class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.date :date
      t.integer :parliamentno
      t.integer :sessionno
      t.integer :periodno
      t.string :chamber

      t.timestamps
    end
  end
end

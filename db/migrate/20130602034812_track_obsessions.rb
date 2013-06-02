class TrackObsessions < ActiveRecord::Migration

  def obsess(nameid)
    data = {}
    Speech.where(:nameid => nameid).each do |sp|
      yearmonth = sp.time.year.to_s + "/" + sp.time.month.to_s
      ym = data[yearmonth] ||= Hash.new(0)

      sp.speech.split(/\s/).each do |word|
        ym[word] += 1
      end
    end
    data.each do |ym, words|
      words.each do |word, count|
        sql = ActiveRecord::Base.send(:sanitize_sql_array,
          ["insert into obsessions (nameid, word, yearmonth, count) values (?, ?, ?, ?)", nameid, word, ym, count]
        )
        execute(sql)
      end
    end
  end

  def up
  	# Abbot: EZ5
  	# Gillard: 83L
    create_table :obsessions do |t|
      t.string :nameid
      t.string :word
  	  t.integer :count
      t.string :yearmonth
    end
    add_index :obsessions, [:nameid, :word, :yearmonth], :unique => true

  end

  def down
  	drop_table :obsessions
  end
end

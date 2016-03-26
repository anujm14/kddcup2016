class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.string :paper_id
      t.string :title
      t.string :publish_year
      t.string :conference_id
      t.string :conference_abbrv
      t.timestamps null: false
    end
  end
end

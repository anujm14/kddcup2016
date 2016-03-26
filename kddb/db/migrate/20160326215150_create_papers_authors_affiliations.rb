class CreatePapersAuthorsAffiliations < ActiveRecord::Migration
  def change
    create_table :papers_authors_affiliations do |t|
      t.string :paper_id
      t.string :author_id
      t.string :affiliation_id
      t.timestamps null: false
    end
  end
end

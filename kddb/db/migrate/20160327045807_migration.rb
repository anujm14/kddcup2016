class Migration < ActiveRecord::Migration
  def change
    add_column :papers_authors_affiliations, :author_score, :decimal
    add_column :papers_authors_affiliations, :affiliation_score, :decimal
  end
end

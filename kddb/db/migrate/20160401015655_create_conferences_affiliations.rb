class CreateConferencesAffiliations < ActiveRecord::Migration
  def change
    create_table :conferences_affiliations do |t|
      t.string  :conference_id
      t.string  :affiliation_id
      t.integer :year
      t.integer :acceptance_count, default: 0
      t.decimal :author_scores, default: 0.0
      t.decimal :author_scores_prime, default: 0.0
      t.decimal :affiliation_scores, default: 0.0
      t.decimal :affiliation_scores_prime, default: 0.0
      t.timestamps null: false
    end
  end
end

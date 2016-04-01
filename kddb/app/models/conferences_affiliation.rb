class ConferencesAffiliation < ActiveRecord::Base
  has_one :affiliation, through: :papers_authors_affiliations
  has_many :papers, through: :papers_authors_affiliations
end

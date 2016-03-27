class Affiliation < ActiveRecord::Base
  has_many :papers_authors_affiliations
  has_many :authors, through: :papers_authors_affiliations
  has_many :papers, through: :papers_authors_affiliations
end

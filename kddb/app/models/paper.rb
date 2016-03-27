class Paper < ActiveRecord::Base
  has_many :papers_authors_affiliations
  has_many :affiliations, through: :papers_authors_affiliations
  has_many :authors, through: :papers_authors_affiliations
end

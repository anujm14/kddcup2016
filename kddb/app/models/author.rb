class Author < ActiveRecord::Base
  has_many :affiliations, through: :papers_authors_affiliations
  has_many :papers, through: :papers_authors_affiliations
end

class PapersAuthorsAffiliation < ActiveRecord::Base
  belongs_to :paper, primary_key: "paper_id"
  belongs_to :author, primary_key: "author_id"
  belongs_to :affiliation, primary_key: "affiliation_id"
end

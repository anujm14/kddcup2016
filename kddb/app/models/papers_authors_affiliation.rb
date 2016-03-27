class PapersAuthorsAffiliation < ActiveRecord::Base
  belongs_to :paper, primary_key: "paper_id"
  belongs_to :author, primary_key: "author_id"
  belongs_to :affiliation, primary_key: "affiliation_id"

  PAPER_POINT = 1.0

  def author_score
    PAPER_POINT / PapersAuthorsAffiliation.where(paper_id: paper_id,
                                                 author_id: author_id).count
  end
  
  def affiliation_score
    author_score / PapersAuthorsAffiliation.where(paper_id: paper_id,
                                                  author_id: author_id,
                                                  affiliation_id: affiliation_id).count
  end
end

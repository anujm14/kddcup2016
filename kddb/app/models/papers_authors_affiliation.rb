class PapersAuthorsAffiliation < ActiveRecord::Base
  belongs_to :paper, primary_key: "paper_id"
  belongs_to :author, primary_key: "author_id"
  belongs_to :affiliation, primary_key: "affiliation_id"

  PAPER_POINT = 1.0

  def score_authors
    count_authors = PapersAuthorsAffiliation.where(paper_id: paper_id).count
    if count_authors == 0
      return 0
    else
      return PAPER_POINT / count_authors
    end
  end

  def score_authors_affiliations
    if Float::INFINITY == score_authors / PapersAuthorsAffiliation.select(:affiliation_id).where(author_id: author_id).uniq.count
      return 0
    else
      score_authors / PapersAuthorsAffiliation.select(:affiliation_id).where(author_id: author_id).uniq.count
    end
  end
end

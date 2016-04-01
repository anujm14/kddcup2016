require 'rubygems'
require 'open-uri'
require 'csv'

KDD_PAPERS_TSV = 'https://s3.amazonaws.com/kddcup2016-ghen/Papers.tsv'
KDD_AFFILIATIONS_TSV = 'https://s3.amazonaws.com/kddcup2016-ghen/Affiliations.tsv'
KDD_PAPERS_AUTHORS_AFFILIATIONS_TSV = 'https://s3.amazonaws.com/kddcup2016-ghen/PapersAuthorsAffiliations.tsv'

PAPER_POINT = 1.0

progress = ProgressBar.create \
    title: "Building Papers from #{KDD_PAPERS_TSV}",
    total: 3677,
    output: Rails.env.test? ? StringIO.new : STDOUT

CSV.foreach(open(KDD_PAPERS_TSV), { :col_sep => "\t" }).with_index do |row, i|
  attrs = { paper_id:  row[0],
            title:  row[1],
            publish_year: row[2],
            conference_id: row[3],
            conference_abbrv: row[4] }

  paper = Paper.new attrs
  paper.save
  progress.increment
end
progress.finish

progress = ProgressBar.create \
    title: "Building Affiliations from #{KDD_AFFILIATIONS_TSV}",
    total: 741,
    output: Rails.env.test? ? StringIO.new : STDOUT

CSV.foreach(open(KDD_AFFILIATIONS_TSV), { :col_sep => "\t" }).with_index do |row, i|
  attrs = { affiliation_id:  row[0],
            name:  row[1] }

  affiliation = Affiliation.new attrs
  affiliation.save
  progress.increment
end
progress.finish

progress = ProgressBar.create \
    title: "Building PapersAuthorsAffiliations from #{KDD_PAPERS_AUTHORS_AFFILIATIONS_TSV}",
    total: 13392,
    output: Rails.env.test? ? StringIO.new : STDOUT

CSV.foreach(open(KDD_PAPERS_AUTHORS_AFFILIATIONS_TSV), { :col_sep => "\t" }).with_index do |row, i|
  attrs = { paper_id: row[0],
            author_id: row[1],
            affiliation_id:  row[2] }

  paper_author_affiliation = PapersAuthorsAffiliation.new attrs
  paper_author_affiliation.save

  progress.increment
end
progress.finish

progress = ProgressBar.create \
    title: "Scoring #{KDD_PAPERS_AUTHORS_AFFILIATIONS_TSV}",
    total: 13392,
    output: Rails.env.test? ? StringIO.new : STDOUT

PapersAuthorsAffiliation.all.each do |paa|
  paa.author_score = paa.score_authors
  paa.affiliation_score = paa.score_authors_affiliations
  paa.save

  progress.increment
end
progress.finish

progress = ProgressBar.create \
    title: "Tabulating affiliation author_scores, affiliation_scores, and acceptance_count",
    total: PapersAuthorsAffiliation.all.count,
    output: Rails.env.test? ? StringIO.new : STDOUT

PapersAuthorsAffiliation.all.each do |paa|
  # Compute author_scores and affiliation_scores
  paper = Paper.where(paper_id: paa.paper_id).first

  ca = ConferencesAffiliation.find_or_create_by(conference_id:   paper.conference_id,
                                           affiliation_id:  paa.affiliation_id,
                                           year:            paper.publish_year)
  ca.update_attributes author_scores: ca.author_scores + paa.author_score,
                       affiliation_scores: ca.affiliation_scores + paa.affiliation_score,
                       acceptance_count: ca.acceptance_count + 1
  ca.save
  progress.increment
end
progress.finish

progress = ProgressBar.create \
    title: "Calculating affiliation author_scores_prime and affiliation_scores_prime",
    total: ConferencesAffiliation.all.count,
    output: Rails.env.test? ? StringIO.new : STDOUT

ConferencesAffiliation.all.each do |ca|
  # Compute author_scores_prime and affiliation_scores_prime
  ca1 = ConferencesAffiliation.where conference_id: ca.conference_id,
                                     affiliation_id: ca.affiliation_id,
                                     year: ca.year - 1
  if ca1.count > 0
    attrs = { author_scores_prime: ca.author_scores - ca1.first.author_scores,
              affiliation_scores_prime: ca.affiliation_scores - ca1.first.affiliation_scores}
    ca.update_attributes attrs
    ca.save
  end

  progress.increment
end
progress.finish

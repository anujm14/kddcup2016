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

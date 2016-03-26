require 'rubygems'
require 'open-uri'
require 'csv'

KDD_PAPERS_TSV = 'https://s3.amazonaws.com/kddcup2016-ghen/Papers.tsv'
KDD_AFFILIATIONS_TSV = 'https://s3.amazonaws.com/kddcup2016-ghen/Affiliations.tsv'
KDD_AUTHORS_TSV = 'https://s3.amazonaws.com/kddcup2016-ghen/Authors.txt'
KDD_PAPERS_AUTHORS_AFFILIATIONS_TSV = 'https://s3.amazonaws.com/kddcup2016-ghen/PapersAuthorsAffiliations.tsv'


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
    total: 10000,
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

# NOTE: This takes a long time...
progress = ProgressBar.create \
    title: "Building Authors from #{KDD_AUTHORS_TSV}",
    total: 1000, # NOTE save some time...
    output: Rails.env.test? ? StringIO.new : STDOUT

CSV.foreach(open(KDD_AUTHORS_TSV), { :col_sep => "\t" }).with_index do |row, i|
  if PapersAuthorsAffiliation.where(author_id: row[0]).count > 0
    attrs = { author_id:  row[0],
              name:  row[1] }

    author = Author.new attrs
    author.save
    progress.increment
  end
end
progress.finish

# Data Integrity check
# 1. All authors appear in at least one PapersAuthorsAffiliation
# 2. All papers appear in at least one PapersAuthorsAffiliation
# 3. All affiliations appear in at least one PapersAuthorsAffiliation

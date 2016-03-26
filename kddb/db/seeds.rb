require 'csv'

KDD_PAPERS_TSV = Rails.root.join 'lib', 'seeds', 'Papers.tsv'
KDD_AFFILIATIONS_TSV = Rails.root.join 'lib', 'seeds', 'Affiliations.tsv'
KDD_AUTHORS_TSV = Rails.root.join 'lib', 'seeds', 'Authors.tsv'

progress = ProgressBar.create \
    title: "building papers from #{KDD_PAPERS_TSV}",
    total: File.open(KDD_PAPERS_TSV).readlines.size,
    output: Rails.env.test? ? StringIO.new : STDOUT

CSV.foreach(KDD_PAPERS_TSV.to_s, { :col_sep => "\t" }).with_index do |row, i|
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
    title: "building affiliations from #{KDD_AFFILIATIONS_TSV}",
    total: File.open(KDD_AFFILIATIONS_TSV).readlines.size,
    output: Rails.env.test? ? StringIO.new : STDOUT

CSV.foreach(KDD_AFFILIATIONS_TSV.to_s, { :col_sep => "\t" }).with_index do |row, i|
  attrs = { affiliation_id:  row[0],
            name:  row[1] }

  affiliation = Affiliation.new attrs
  affiliation.save
  progress.increment
end
progress.finish

progress = ProgressBar.create \
    title: "building authors from #{KDD_AUTHORS_TSV}",
    total: 114698044, # NOTE save some time...
    output: Rails.env.test? ? StringIO.new : STDOUT

CSV.foreach(KDD_AUTHORS_TSV.to_s, { :col_sep => "\t" }).with_index do |row, i|
  attrs = { author_id:  row[0],
            name:  row[1] }

  author = Author.new attrs
  author.save
  progress.increment
end
progress.finish

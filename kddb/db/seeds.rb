require 'csv'

KDD_PAPERS_TSV = Rails.root.join 'lib', 'seeds', 'Papers.tsv'
KDD_AFFILIATIONS_TSV = Rails.root.join 'lib', 'seeds', 'Affiliations.tsv'

# progress = ProgressBar.create \
#     title: "building papers from #{csv}",
#     total: count,
#     output: Rails.env.test? ? StringIO.new : STDOUT

CSV.foreach(KDD_PAPERS_TSV.to_s, { :col_sep => "\t" }).with_index do |row, i|
  attrs = { paper_id:  row[0],
            title:  row[1],
            publish_year: row[2],
            conference_id: row[3],
            conference_abbrv: row[4] }

  paper = Paper.new attrs
  paper.save
  puts "Saved", paper
end

CSV.foreach(KDD_AFFILIATIONS_TSV.to_s, { :col_sep => "\t" }).with_index do |row, i|
  attrs = { affiliation_id:  row[0],
            name:  row[1] }

  affiliation = Affiliation.new attrs
  affiliation.save
  puts "Saved", affiliation
end

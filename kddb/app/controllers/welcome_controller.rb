class WelcomeController < ApplicationController
  def index
    @papers_authors_affiliations = []
    papers_authors_affiliation = PapersAuthorsAffiliation.all
    papers_authors_affiliation.each do |paa|
      paper = Paper.where(paper_id: paa[:paper_id]).first
      author = Author.where(author_id: paa[:author_id]).first
      affiliation = Affiliation.where(affiliation_id: paa[:affiliation_id]).first
      if paper != nil && author != nil && affiliation != nil
        @papers_authors_affiliations << {paper:paper,author:author,affiliation:affiliation}
      end
    end


  end
end

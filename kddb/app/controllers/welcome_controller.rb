class WelcomeController < ApplicationController
  def index
    @papers_authors_affiliations = PapersAuthorsAffiliation.joins(:paper,:affiliation).order('conference_id')
  end
end

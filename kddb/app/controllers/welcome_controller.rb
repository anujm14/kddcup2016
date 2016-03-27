class WelcomeController < ApplicationController
  def index
    @papers_authors_affiliations = PapersAuthorsAffiliation.joins(:paper, :author,:affiliation)
  end
end

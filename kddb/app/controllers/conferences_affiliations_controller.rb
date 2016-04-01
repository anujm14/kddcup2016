class ConferencesAffiliationsController < ApplicationController
  before_action :set_conferences_affiliation, only: [:show, :edit, :update, :destroy]

  # GET /conferences_affiliations
  # GET /conferences_affiliations.json
  def index
    @conferences_affiliations = ConferencesAffiliation.all
  end

  # GET /conferences_affiliations/1
  # GET /conferences_affiliations/1.json
  def show
  end

  # GET /conferences_affiliations/new
  def new
    @conferences_affiliation = ConferencesAffiliation.new
  end

  # GET /conferences_affiliations/1/edit
  def edit
  end

  # POST /conferences_affiliations
  # POST /conferences_affiliations.json
  def create
    @conferences_affiliation = ConferencesAffiliation.new(conferences_affiliation_params)

    respond_to do |format|
      if @conferences_affiliation.save
        format.html { redirect_to @conferences_affiliation, notice: 'Conferences affiliation was successfully created.' }
        format.json { render :show, status: :created, location: @conferences_affiliation }
      else
        format.html { render :new }
        format.json { render json: @conferences_affiliation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conferences_affiliations/1
  # PATCH/PUT /conferences_affiliations/1.json
  def update
    respond_to do |format|
      if @conferences_affiliation.update(conferences_affiliation_params)
        format.html { redirect_to @conferences_affiliation, notice: 'Conferences affiliation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conferences_affiliation }
      else
        format.html { render :edit }
        format.json { render json: @conferences_affiliation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conferences_affiliations/1
  # DELETE /conferences_affiliations/1.json
  def destroy
    @conferences_affiliation.destroy
    respond_to do |format|
      format.html { redirect_to conferences_affiliations_url, notice: 'Conferences affiliation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conferences_affiliation
      @conferences_affiliation = ConferencesAffiliation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conferences_affiliation_params
      params.fetch(:conferences_affiliation, {})
    end
end

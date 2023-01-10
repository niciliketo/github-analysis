# frozen_string_literal: true

class PullRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_repo
  before_action :set_pull_request, only: %i[show edit update destroy]

  # GET /pull_requests
  # GET /pull_requests.json
  def index
    authorize @repo, :show?
    @search = PullRequestSearchForm.new(pull_request_search_params)
    @pull_requests = policy_scope(PullRequest).where(@search.serialize)
  end

  # GET /pull_requests/1
  # GET /pull_requests/1.json
  def show
    authorize @pull_request.repo, :show?
  end

  # GET /pull_requests/new
  def new
    authorize @repo, :show?
    @pull_request = PullRequest.new
  end

  # GET /pull_requests/1/edit
  def edit
    authorize @pull_request.repo, :show?
  end

  # POST /pull_requests
  # POST /pull_requests.json
  def create
    authorize @repo, :show?
    @pull_request = PullRequest.new(pull_request_params)
    @pull_request.repo = @repo
    respond_to do |format|
      if @pull_request.save
        format.html { redirect_to [@repo, @pull_request], notice: 'Pull request was successfully created.' }
        format.json { render :show, status: :created, location: @pull_request }
      else
        format.html { render :new }
        format.json { render json: @pull_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pull_requests/1
  # PATCH/PUT /pull_requests/1.json
  def update
    authorize @repo, :show?
    respond_to do |format|
      if @pull_request.update(pull_request_params)
        format.html { redirect_to [@repo, @pull_request], notice: 'Pull request was successfully updated.' }
        format.json { render :show, status: :ok, location: @pull_request }
      else
        format.html { render :edit }
        format.json { render json: @pull_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pull_requests/1
  # DELETE /pull_requests/1.json
  def destroy
    authorize @repo, :show?
    @pull_request.destroy
    respond_to do |format|
      format.html { redirect_to repo_pull_requests_url(@repo), notice: 'Pull request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pull_request
    @pull_request = PullRequest.find(params[:id])
  end

  def set_repo
    @repo = Repo.find(params[:repo_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pull_request_params
    params.require(:pull_request).permit(:number, :creator, :milestone, :pr_created_at, :pr_merged_at)
  end

  def pull_request_search_params
    params.fetch(:pull_request_search_form, {}).permit(:number, :pr_created_at, :pr_merged_at_start, :pr_merged_at_end,
                                                       :merged_by, milestone: [], creator: [], merged_by: [])
  end
end

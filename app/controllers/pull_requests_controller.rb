class PullRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_repo
  before_action :set_pull_request, only: [:show, :edit, :update, :destroy]

  # GET /pull_requests
  # GET /pull_requests.json
  def index
    @search = PullRequestForm.new(pull_request_form_params)
    @pull_requests = @repo.pull_requests.where(@search.serialize)
  end

  # GET /pull_requests/1
  # GET /pull_requests/1.json
  def show
  end

  # GET /pull_requests/new
  def new
    @pull_request = PullRequest.new
  end

  # GET /pull_requests/1/edit
  def edit
  end

  # POST /pull_requests
  # POST /pull_requests.json
  def create
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

    def pull_request_form_params
      params.fetch(:pull_request_form, {}).permit(:number, :creator, :milestone, :pr_created_at, :pr_merged_at_start, :pr_merged_at_end, :merged_by)
    end
end

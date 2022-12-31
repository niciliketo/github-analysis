# frozen_string_literal: true

# Object representing a users GitHub repo
class Repo < ApplicationRecord
  belongs_to :user
  has_many :pull_requests, dependent: :destroy

  # Go through all the PRs and get the data
  def self.generate_data
    Repo.find_in_batches do |group|
      group.each(&:generate_data)
    end
  end

  def generate_data
    logger.info "Generating data for #{self.full_name}"
    @client = Octokit::Client.new(:access_token => credentials)
    next_page = true
    pull_requests = @client.pull_requests(full_name, state: 'closed', per_page: 100)
    until pull_requests.length == 0 || next_page == false do
      next_page =  @client.last_response.rels[:next].href
      logger.info "[#{Time.now}] Now processing: #{full_name}, #{pull_requests.first.number} to #{pull_requests.last.number}."
      pull_requests.each do |pr|
        # Dont re-process if we already have it...
        # TODO: better logic here, we cannot process everything every time!
        next if PullRequest.where(repo: self, number: pr.number).size > 0
        full_pr = @client.pull_request(full_name, pr.number)
        pr = PullRequest.new(repo: self, number: pr.number, creator: full_pr.user.login,
                        milestone: full_pr.milestone&.title, merged_by: full_pr&.merged_by&.login,
                        pr_created_at: full_pr.created_at, pr_merged_at: full_pr&.merged_at,
                        data: pr.to_json)
        pr.save!
        puts pr.number
      end
      pull_requests = @client.get(next_page)
      next_page =  !@client.last_response.rels[:next].nil?
    end
    self.checked_at = Time.now
    self.save!
  end

  # Some nice methods to help with the view
  def min_pr_merged_at
    pull_requests_stats.min_pr_merged_at.to_date
  end

  def max_pr_merged_at
    pull_requests_stats.max_pr_merged_at.to_date
  end

  def milestones
    pull_requests_stats.milestones.split(',').sort
  end

  def creators
    pull_requests_stats.creators.split(',').sort
  end

  def merged_bys
    pull_requests_stats.merged_bys.split(',').sort
  end

  private

  def credentials
    user.access_token
  end

  def pull_requests_stats
    @pull_requests_stats ||=
      pull_requests.select('COUNT(*) sum_prs, MIN(pr_merged_at) min_pr_merged_at, MAX(pr_merged_at) max_pr_merged_at,'\
                           ' GROUP_CONCAT(DISTINCT(milestone)) milestones, GROUP_CONCAT(DISTINCT(merged_by))'\
                           ' merged_bys, GROUP_CONCAT(DISTINCT(creator)) creators').first
  end
end

class PullRequest < ApplicationRecord
  def self.generate_data
    @client = Octokit::Client.new(:access_token => get_credentials)

    next_page = true
    pull_requests = @client.pull_requests('niciliketo/auction', state: 'closed', per_page: 100)
    until next_page == false do
      next_page =  @client.last_response.rels[:next].href
      pull_requests.each do |pr|
        # Dont re-process if we already have it...
        if PullRequest.where(number: pr.number)
          puts "already recorded PR #{pr.number}"
          exit
        end
        full_pr = @client.pull_request("niciliketo/auction", pr.number)
        pr = PullRequest.new(number: pr.number, creator: full_pr.user.login, 
                        milestone: full_pr.milestone&.title, merged_by: full_pr&.merged_by&.login, 
                        pr_created_at: full_pr.created_at, pr_merged_at: full_pr&.merged_at,
                        data: pr.to_json)
        pr.save!
        puts pr.number
      end
      pull_requests = @client.get(next_page)
      next_page =  @client.last_response.rels[:next].href
      puts "[#{Time.now}] Now processing: #{next_page}"
    end
  end

  private
  def self.get_credentials
    Rails.application.credentials.github[:access_token]
  end
end

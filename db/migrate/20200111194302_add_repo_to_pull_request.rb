class AddRepoToPullRequest < ActiveRecord::Migration[6.0]
  def change
    add_reference :pull_requests, :repo, foreign_key: true
  end
end

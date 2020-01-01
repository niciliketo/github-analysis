class AddDataToPullRequest < ActiveRecord::Migration[6.0]
  def change
    add_column(:pull_requests, :data, :json)
  end
end

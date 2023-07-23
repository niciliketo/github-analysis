# frozen_string_literal: true

json.extract! repo, :id, :user_id, :pull_request_id, :url, :data, :created_at, :updated_at
json.url repo_url(repo, format: :json)

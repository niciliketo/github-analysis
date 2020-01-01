json.extract! pull_request, :id, :number, :creator, :milestone, :pr_created_at, :pr_merged_at, :data, :created_at, :updated_at
json.url pull_request_url(pull_request, format: :json)

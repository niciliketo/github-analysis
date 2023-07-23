# frozen_string_literal: true

class PullRequest < ApplicationRecord
  belongs_to :repo
  # TODO:
  # serialize :data, JSON

  def serialized_data
    return @serialized_data if defined? @serialized_data

    @serialized_data = JSON.parse(data)
  end
end

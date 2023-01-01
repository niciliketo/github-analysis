# frozen_string_literal: true

class PullRequest < ApplicationRecord
  belongs_to :repo
end

# frozen_string_literal: true

json.array! @repos, partial: 'repos/repo', as: :repo

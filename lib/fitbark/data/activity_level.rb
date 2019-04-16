module Fitbark
  module Data
    # define user info data structure
    class ActivityLevel < OpenStruct
      include Fitbark::Data::Shared
      # property :min_play
      # property :min_active
      # property :min_rest
    end
  end
end

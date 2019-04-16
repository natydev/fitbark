module Fitbark
  module Data
    # define user info data structure
    class ActivityHourly < OpenStruct
      include Fitbark::Data::Shared
      # property :date
      # property :activity_value
      # property :min_play
      # property :min_active
      # property :min_rest
      # property :distance_in_miles
      # property :kcalories
      # property :activity_goal

      def date
        time_parser(self[:date])
      end

      def detected_at
        date
      end
    end
  end
end

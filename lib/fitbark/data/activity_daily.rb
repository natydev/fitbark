module Fitbark
  module Data
    # define user info data structure
    class ActivityDaily < OpenStruct
      include Fitbark::Data::Shared
      # property :date
      # property :activity_value
      # property :activity_average
      # property :min_play
      # property :min_active
      # property :min_rest
      # property :daily_target
      # property :has_trophy

      def date
        date_parser(self[:date])
      end

      def detected_on
        date
      end

      def trophy?
        !self[:has_trophy].zero?
      end
    end
  end
end

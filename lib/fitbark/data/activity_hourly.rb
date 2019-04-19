module Fitbark
  module Data
    # Defines structure for dog's hourly activity data.
    #
    # Original attribute names from source API: 
    # - *date*
    # - *activity_value*
    # - *min_play*,
    # - *min_active*
    # - *min_rest*
    # - *distance_in_miles*
    # - *kcalories*
    # - *activity_goal*
    class ActivityHourly < StrictOpenStruct
      include Fitbark::Data::Shared

      # parse String value into Time for *date* attribute
      def date
        time_parser(self[:date])
      end

      alias detected_at date

      # an alias for *min_play* attribute
      def minutes_playing
        self[:min_play]
      end

      # an alias for *min_active* attribute
      def minutes_active
        self[:min_active]
      end

      # an alias for *min_rest* attribute
      def minutes_resting
        self[:min_rest]
      end

      # convert in kilometers from *distance_in_miles* attribute
      def distance_in_kms
        (self[:distance_in_miles].to_f * 1.60934).round(3)
      end

    end
  end
end

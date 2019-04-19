module Fitbark
  module Data
    # Defines structure for dog's daily activity data.
    #
    # Original attribute names from source API: 
    # - *date*
    # - *activity_value*
    # - *activity_average*, 
    # - *min_play*,
    # - *min_active*
    # - *min_rest*
    # - *daily_target*
    # - *has_trophy*
    class ActivityDaily < StrictOpenStruct
      include Fitbark::Data::Shared

      # parse source String value into Date for *date* attribute
      def date
        date_parser(self[:date])
      end

      alias detected_on date

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

      # an alias for *daily_target* attribute
      def daily_goal
        self[:daily_target]
      end

      # a predicate alias for *has_trophy* attribute
      def trophy?
        !self[:has_trophy].zero?
      end

      alias daily_goal_reached? trophy?
    end
  end
end

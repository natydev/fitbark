module Fitbark
  module Data
    # Defines structure for dog's daily points goal.
    #
    # Original attribute names from source API:  
    # - *goal*,
    # - *date*
    class DailyGoal < StrictOpenStruct
      include Fitbark::Data::Shared

      # parse String value into Date for *date* attribute
      def date
        date_parser(self[:date])
      end

      alias set_on date

      # an alias for *goal* attribute
      def goal_points
        self[:goal]
      end

    end
  end
end

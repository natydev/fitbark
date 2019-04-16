module Fitbark
  module Data
    # define user info data structure
    class DailyGoal < OpenStruct
      include Fitbark::Data::Shared
      # property :goal
      # property :date

      def goal_points
        self[:goal]
      end

      def set_on
        date_parser(self[:date])
      end
    end
  end
end

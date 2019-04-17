module Fitbark
  module Handler
    module V2
      # Fitbark::Handler::V2::DailyGoals class
      class DailyGoals
        include Fitbark::Handler::V2::Base

        # https://app.fitbark.com/api/v2/daily_goal/{dog_slug}
        def response
          json_response['daily_goals'].map do |dg|
            Fitbark::Data::DailyGoal.new(dg)
          end
        end

        private

        def raw_response
          connection(fragment: "daily_goal/#{opts[:dog_slug]}").body
        end
      end
    end
  end
end

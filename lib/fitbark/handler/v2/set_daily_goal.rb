module Fitbark
  module Handler
    module V2
      # Fitbark::Handler::V2::SetDailyGoal class
      class SetDailyGoal
        include Fitbark::Handler::V2::Base

        def initialize(token:, opts: {})
          super
          validate_input
        end

        # https://app.fitbark.com/api/v2/daily_goal/{dog_slug}
        def response
          json_response['daily_goals'].map do |dg|
            Fitbark::Data::DailyGoal.new(dg)
          end
        end

        private

        def raw_response
          connection(verb: :put, fragment: "daily_goal/#{opts[:dog_slug]}",
                     params: build_params(opts[:goal_points],
                                          opts[:set_on])).body
        end

        def build_params(goal_points, set_on)
          {
            "daily_goal": goal_points.to_s,
            "date": set_on.to_s
          }
        end

        def validate_input
          unless opts[:goal_points].instance_of?(Integer)
            raise Fitbark::Errors::FormatError
              .new(message: "Wrong or missing integer for param 'goal_points'")
          end
          unless opts[:set_on].instance_of?(Date)
            raise Fitbark::Errors::FormatError
              .new(message: "Wrong or missing date for param 'set_on'")
          end
          if opts[:set_on] < Date.today
            raise Fitbark::Errors::FormatError
              .new(message: "Param 'set_on' must be equal or greater than today date")
          end
        end
      end
    end
  end
end

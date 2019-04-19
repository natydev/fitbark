module Fitbark
  module Handler
    module V2
      # = \#set_daily_goal
      # Fitbark::Handler::V2::SetDailyGoal define method *set_daily_goal*
      # inside Client object
      #
      # === params (key/value):
      #
      # - *dog_slug*: slug ID relative to dog (String)
      # - *goal_points*: goal points to set (Integer)
      # - *set_on*: date from the goal will start to set (Date)
      #
      # example usage:
      #   client = Client.new(token: 'a5b3f8...')
      #   client.set_daily_goal(dog_slug: 'v4s1...', set_on: 1.month.from_now, goal_points: 11000)
      #
      # === response:
      # An array of Fitbark::Data::DailyGoal objects.
      class SetDailyGoal
        include Fitbark::Handler::V2::Base

        # :nodoc:
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

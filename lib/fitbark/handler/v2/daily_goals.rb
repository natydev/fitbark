module Fitbark
  module Handler
    module V2
      # = \#daily_goals
      # Fitbark::Handler::V2::DailyGoals define method *daily_goals*
      # inside Client object
      #
      # === params (key/value):
      #
      # - *dog_slug*: slug ID relative to dog (String)
      #
      # example usage:
      #   client = Client.new(token: 'a5b3f8...')
      #   client.daily_goals(dog_slug: 'v4s1...')
      #
      # === response:
      # An array of Fitbark::Data::DailyGoal objects.
      class DailyGoals
        include Fitbark::Handler::V2::Base

        # :nodoc:
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

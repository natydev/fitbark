module Fitbark
  module Handler
    module V2
      # = \#time_breakdown
      # Fitbark::Handler::V2::TimeBreakdown define method *time_breakdown*
      # inside Client object
      #
      # === params (key/value):
      #
      # - *dog_slug*: slug ID relative to dog (String)
      # - *from*: data start date (Date)
      # - *to*: data end date (Date)
      #
      # example usage:
      #   client = Client.new(token: 'a5b3f8...')
      #   client.time_breakdown(dog_slug: 'v4s1...', from: 3.days.ago, to: Date.today)
      #
      # === response:
      # return a Fitbark::Data::ActivityLevel object.
      class TimeBreakdown
        include Fitbark::Handler::V2::Base

        # :nodoc:
        def initialize(token:, opts: {})
          super
          validate_input
        end

        # https://app.fitbark.com/api/v2/time_breakdown
        def response
          Fitbark::Data::ActivityLevel.new(json_response['activity_level'])
        end

        private

        def raw_response
          connection(verb: :post, fragment: 'time_breakdown',
                     params: build_params(opts[:dog_slug], opts[:from],
                                          opts[:to])).body
        end

        def build_params(slug, from, to)
          {
            "dog": {
              "slug": slug,
              "from": from,
              "to": to
            }
          }
        end

        def validate_input
          unless opts[:from].instance_of?(Date)
            Fitbark::Errors::FormatError.new(message: "Wrong or missing date for param 'from'")
          end
          unless opts[:to].instance_of?(Date)
            Fitbark::Errors::FormatError.new(message: "Wrong or missing date for param 'to'")
          end
        end
      end
    end
  end
end

module Fitbark
  module Handler
    module V2
      # Fitbark::Handler::V2::ActivityTotal class
      class ActivityTotal
        include Fitbark::Handler::V2::Base

        def initialize(token:, opts: {})
          super
          validate_input
        end

        # https://app.fitbark.com/api/v2/activity_totals
        def response
          json_response['activity_value'].to_i
        end

        private

        def raw_response
          connection(verb: :post, fragment: 'activity_totals',
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
            raise Fitbark::Errors::FormatError
              .new(message: "Wrong or missing date for param 'from'")
          end
          unless opts[:to].instance_of?(Date)
            raise Fitbark::Errors::FormatError
              .new(message: "Wrong or missing date for param 'to'")
          end
        end
      end
    end
  end
end

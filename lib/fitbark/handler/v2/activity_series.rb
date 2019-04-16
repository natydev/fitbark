module Fitbark
  module Handler
    module V2
      # Fitbark::Handler::V2::User class
      class ActivitySeries
        include Fitbark::Handler::V2::Base

        RESOLUTIONS = %i[daily hourly].freeze

        def initialize(token:, opts: {})
          super
          @resolution = opts.fetch(:resolution, '').to_s.downcase.to_sym
          validate_input
        end

        attr_reader :resolution

        # https://app.fitbark.com/api/v2/activity_series
        def response
          json_response.dig('activity_series', 'records').map do |as|
            data_class.new(as)
          end
        end

        private

        def raw_response
          connection(verb: :post, fragment: 'activity_series',
                     params: build_params(opts[:dog_slug], opts[:from],
                                          opts[:to], resolution)).body
        end

        def build_params(slug, from, to, res)
          {
            "activity_series": {
              "slug": slug,
              "from": from,
              "to": to,
              "resolution": format_resolution(res)
            }
          }
        end

        def format_resolution(val)
          val.to_s.upcase
        end

        def validate_input
          unless RESOLUTIONS.include? resolution
            raise(Fitbark::Errors::FormatError
              .new(message: "Wrong or missing param 'resolution', must be kind of:
               #{Fitbark::Handler::V2::ActivitySeries::RESOLUTIONS.join(', ')}"))
          end
          unless opts[:from].instance_of?(Date)
            Fitbark::Errors::FormatError.new(message: "Wrong or missing date for param 'from'")
          end
          unless opts[:to].instance_of?(Date)
            Fitbark::Errors::FormatError.new(message: "Wrong or missing date for param 'to'")
          end
        end

        def data_class
          eval("Fitbark::Data::Activity#{camel(resolution.to_s)}")
        end
      end
    end
  end
end

module Fitbark
  module Handler
    module V2
      # = \#activity_series
      # Fitbark::Handler::V2::ActivitySeries define method *activity_series*
      # inside Client object
      #
      # === params (key/value):
      #
      # - *dog_slug*: slug ID relative to dog (String)
      # - *from*: data start date (Date)
      # - *to*: data end date (Date)
      # - *resolution*: can be +:daily+ or +:hourly+ (Symbol)
      #
      # example usage:
      #   client = Client.new(token: 'a5b3f8...')
      #   client.activity_series(dog_slug: 'v4s1...', from: 3.days.ago, to: Date.today, resolution: :daily)
      #
      # === response:
      # when resolution is +:daily+:: An array of
      #                               Fitbark::Data::ActivityDaily objects.
      # when resolution is +:hourly+:: An array of
      #                                Fitbark::Data::ActivityHourly objects.
      class ActivitySeries
        include Fitbark::Handler::V2::Base

        # :nodoc:
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
            raise Fitbark::Errors::FormatError
              .new(message: "Wrong or missing date for param 'from'")
          end
          unless opts[:to].instance_of?(Date)
            raise Fitbark::Errors::FormatError
              .new(message: "Wrong or missing date for param 'to'")
          end
        end

        def data_class
          eval("Fitbark::Data::Activity#{camel(resolution.to_s)}")
        end
      end
    end
  end
end

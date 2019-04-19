module Fitbark
  module Handler
    module V2
      # provide base behaviour for all handler classes.
      module Base
        include Fitbark::Constants

        # :nodoc:
        def initialize(token:, opts: {})
          @token = token
          @opts = opts
          @uri = Addressable::URI.new(host: API_HOST, scheme: API_SCHEME,
                                      path: API_SUBHOST)
        end

        attr_reader :uri

        private

        attr_reader :token, :opts

        def connection(verb: :get, fragment:, params: {})
          conn = Faraday.new(url: uri.to_s).public_send(verb) do |req|
            req.url fragment
            req.params = params
            req.headers = {
              'Content-Type' => 'application/json',
              'Authorization' => "Bearer #{token}"
            }
          end
          check_errors(conn)
          conn
        end

        private

        def json_response
          Oj.load(raw_response)
        rescue Oj::ParseError => e
          raise(DataError.new(message: e.message))
        end

        def check_errors(conn)
          unless conn.success?
            raise(Fitbark::Errors::ConnectionError
              .new(message: "#{conn.reason_phrase} #{conn.body}",
                   code: conn.status))
          end
        end
      end
      # ^ Base
    end
  end
end

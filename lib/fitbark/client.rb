module Fitbark
  # client class
  class Client
    include Fitbark::Constants

    def initialize(token:)
      raise Fitbark::Errors::TokenNotProvidedError if token.nil?

      @token = token
      @uri = Addressable::URI.new(host: API_HOST, scheme: API_SCHEME,
                                  path: API_SUBHOST)
    end

    attr_reader :uri

    # https://app.fitbark.com/api/v2/user
    def user
      JSON.parse(connection(fragment: 'user').body)
    end

    def method_name; end

    private

    attr_reader :token

    def connection(verb: :get, fragment:)
      Faraday.new(url: uri).public_send(verb) do |req|
        req.url fragment
        req.headers = {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{token}"
        }
      end
    end
  end
end

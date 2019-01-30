module Fitbark
  # Fitbark::Auth provide oauth2 methods
  class Auth
    include Fitbark::Constants

    def initialize(client_id: nil, client_secret: nil,
                   redirect_uri: nil, code: nil, token: nil)
      @client_id = client_id
      @client_secret = client_secret
      @redirect_uri = redirect_uri
      @code = code
      @token = read_token(token)
      @uri = Addressable::URI.new(host: API_HOST, scheme: API_SCHEME)
    end

    attr_accessor :code
    attr_writer :token
    attr_reader :client_id, :client_secret, :redirect_uri,
                :token_data, :token_info

    def authorization_uri
      uri.path = AUTHORIZE_PATH
      uri.query_values = {
        response_type: :code,
        client_id: client_id,
        redirect_uri: redirect_uri
      }
      uri.to_s
    end

    def fetch_access_token!
      if token_response.success?
        apply_token_data(token_response)
      else
        token_error(token_response)
      end
    end

    def fetch_token_info
      response = token_info_response
      if response.success?
        apply_token_info(response)
      else
        token_error(response)
      end
    end

    def token
      read_token
    end

    private

    attr_accessor :uri

    def token_response
      @token_response ||= Faraday.new(url: uri.site).post do |req|
        req.url TOKEN_PATH
        req.body = request_token_body
      end
    end

    def request_token_body
      {
        client_id: client_id,
        client_secret: client_secret,
        grant_type: :authorization_code,
        redirect_uri: redirect_uri,
        code: code
      }
    end

    def token_info_response
      raise Fitbark::Errors::TokenNotProvidedError if token.nil?

      Faraday.new(url: uri.site).get do |req|
        req.url TOKEN_INFO_PATH
        req.headers = {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{token}"
        }
      end
    end

    def apply_token_data(resp)
      @token_data = Fitbark::Data::Token.new(parsed_body(resp))
    end

    def apply_token_info(resp)
      @token_info = Fitbark::Data::TokenInfo.new(parsed_body(resp))
    end

    def token_error(resp)
      raise(Fitbark::Errors::FetchTokenError
        .new(code: resp.status, message:
        parsed_body(resp)['error_description']))
    end

    def read_token(val = @token)
      (token_data.respond_to?(:token) && token_data.token) || val
    end

    def parsed_body(resp)
      JSON.parse(resp.body)
    end
  end
end

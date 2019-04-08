module Fitbark
  # this module provide constants support
  module Constants
    API_SCHEME = 'https'.freeze
    API_HOST = 'app.fitbark.com'.freeze
    API_SUBHOST = 'api/v2'.freeze
    AUTHORIZE_PATH = '/oauth/authorize'.freeze
    TOKEN_PATH = '/oauth/token'.freeze
    TOKEN_INFO_PATH = TOKEN_PATH + '/info'.freeze
    PREFIX_NAME_HANDLER = 'Fitbark::Handler::V2::'.freeze
  end
end

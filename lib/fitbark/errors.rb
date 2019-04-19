module Fitbark
  # Provides namespace for error classes.
  module Errors
    # provide base behaviour for all errors classes.
    class BaseError < StandardError
      def initialize(message: nil, code: 400)
        @message = message
        @code = code
      end

      attr_accessor :message, :code

      def to_s
        "#{code} - #{message}"
      end
    end

    # FetchTokenError
    class FetchTokenError < BaseError; end
    # TokenNotProvidedError
    class TokenNotProvidedError < BaseError
      def initialize
        @message = 'Token is required for this operation'
      end
    end
    # ConnectionError
    class ConnectionError < BaseError; end
    # DataError
    class DataError < BaseError; end
    # FormatError
    class FormatError < BaseError; end
  end
end

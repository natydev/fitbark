module Fitbark
  # this module provide error classes
  module Errors
    # common base error class
    class BaseError < StandardError
      def initialize(args = {})
        @message = args.fetch(:message, nil)
        @code = args.fetch(:code, 400)
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
  end
end

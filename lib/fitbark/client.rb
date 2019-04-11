module Fitbark
  # client class
  class Client
    include Fitbark::Constants

    def initialize(token:)
      raise Fitbark::Errors::TokenNotProvidedError if token.nil?

      @token = token
    end

    attr_reader :uri

    def method_missing(method, **args)
      if respond_to?(method)
        klass_handler(method).new(token: token, opts: args).response
      else
        super
      end
    end

    def respond_to?(method, include_private = false)
      return true if klass_handler(method)
    rescue NameError => e
      super
    end

    private

    def klass_handler(handler)
      eval("#{PREFIX_NAME_HANDLER}#{handler.to_s.split('_')
        .collect(&:capitalize).join}")
    end

    attr_reader :token
  end
end

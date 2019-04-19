module Fitbark
  # Provides all methods to connect to the API
  # endpoints and retrieve data 
  class Client
    include Fitbark::Constants

    # === params (key/value):
    #
    # - *token*: access token retrieved from Fitbark::Auth
    #
    # alla available API methods inside
    # this calss are dynamical defined by all Fitbark::Handler::V2 classes
    # please read specific documentation for each of them
    # == Sample usage:
    #
    #   token = "9083a4b0d701542c9b..."
    #   client = Fitbark::Client.new(token: token)
    #   user = client.user_info
    #   first_dog = client.dog_relations.first.dog
    #   client.dog_picture(dog_slug: first_dog.slug)

    def initialize(token:)
      raise Fitbark::Errors::TokenNotProvidedError if token.nil?

      @token = token
    end

    attr_reader :uri

    # :nodoc:
    def method_missing(method, **args)
      if respond_to?(method)
        klass_handler(method).new(token: token, opts: args).response
      else
        super
      end
    end

    # :nodoc:
    def respond_to?(method, include_private = false)
      return true if klass_handler(method)
    rescue NameError => e
      super
    end

    private

    def klass_handler(handler)
      eval("#{PREFIX_NAME_HANDLER}#{camel(handler.to_s)}")
    end

    attr_reader :token
  end
end

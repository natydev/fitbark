module Fitbark
  module Handler
    module V2
      # = \#dog_info
      # Fitbark::Handler::V2::DogInfo define method *dog_info*
      # inside Client object
      #
      # === params (key/value):
      #
      # - *dog_slug*: slug ID relative to dog (String)
      #
      # example usage:
      #   client = Client.new(token: 'a5b3f8...')
      #   client.dog_info(dog_slug: 'v4s1...')
      #
      # === response:
      # return a Fitbark::Data::DogInfo object.
      class DogInfo
        include Fitbark::Handler::V2::Base

        # :nodoc:
        # https://app.fitbark.com/api/v2/dog/{dog_slug}
        def response
          Fitbark::Data::DogInfo.new(json_response['dog'])
        end

        private

        def json_response
          Oj.load(raw_response)
        end

        def raw_response
          connection(fragment: "dog/#{opts[:dog_slug]}").body
        end
      end
    end
  end
end

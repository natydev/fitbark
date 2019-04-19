module Fitbark
  module Handler
    module V2
      # = \#dog_picture
      # Fitbark::Handler::V2::DogPicture define method *dog_picture*
      # inside Client object
      #
      # === params (key/value):
      #
      # - *dog_slug*: slug ID relative to dog (String)
      #
      # example usage:
      #   client = Client.new(token: 'a5b3f8...')
      #   client.dog_picture(dog_slug: 'v4s1...')
      #
      # === response:
      # return a Fitbark::Data::Picture object.
      class DogPicture
        include Fitbark::Handler::V2::Base

        # :nodoc:
        # https://app.fitbark.com/api/v2/picture/dog/{dog_slug}
        def response
          Fitbark::Data::Picture.new(json_response['image'])
        end

        private

        def json_response
          Oj.load(raw_response)
        end

        def raw_response
          connection(fragment: "picture/dog/#{opts[:dog_slug]}").body
        end
      end
    end
  end
end

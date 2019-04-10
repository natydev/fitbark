module Fitbark
  module Handler
    module V2
      # Fitbark::Handler::V2::DogPicture class
      class DogPicture
        include Fitbark::Handler::V2::Base

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

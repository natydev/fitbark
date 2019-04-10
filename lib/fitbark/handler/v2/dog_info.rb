module Fitbark
  module Handler
    module V2
      # Fitbark::Handler::V2::User class
      class DogInfo
        include Fitbark::Handler::V2::Base

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

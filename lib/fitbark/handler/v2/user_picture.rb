module Fitbark
  module Handler
    module V2
      # Fitbark::Handler::V2::UserPicture class
      class UserPicture
        include Fitbark::Handler::V2::Base

        # https://app.fitbark.com/api/v2/user
        def response
          Fitbark::Data::Picture.new(json_response['image'])
        end

        private

        def json_response
          Oj.load(raw_response)
        end

        def raw_response
          connection(fragment: "picture/user/#{opts[:user_slug]}").body
        end
      end
    end
  end
end

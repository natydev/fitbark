module Fitbark
  module Handler
    module V2
      # Fitbark::Handler::V2::User class
      class UserInfo
        include Fitbark::Handler::V2::Base

        # https://app.fitbark.com/api/v2/user
        def response
          Fitbark::Data::UserInfo.new(json_response['user'])
        end

        private

        def raw_response
          connection(fragment: 'user').body
        end
      end
    end
  end
end

module Fitbark
  module Handler
    module V2
      # = \#user_info
      # Fitbark::Handler::V2::UserInfo define method *user_info*
      # inside Client object
      #
      # === params (key/value):
      #
      # - no params required
      #
      # example usage:
      #   client = Client.new(token: 'a5b3f8...')
      #   client.user_info
      #
      # === response:
      # return a Fitbark::Data::UserInfo object.
      class UserInfo
        include Fitbark::Handler::V2::Base

        # :nodoc:
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

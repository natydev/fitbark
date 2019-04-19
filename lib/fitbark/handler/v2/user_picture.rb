module Fitbark
  module Handler
    module V2
      # = \#user_picture
      # Fitbark::Handler::V2::UserPicture define method *user_picture*
      # inside Client object
      #
      # === params (key/value):
      #
      # - *user_slug*: slug ID relative to user (String)
      #
      # example usage:
      #   client = Client.new(token: 'a5b3f8...')
      #   client.user_picture(user_slug: 'v4s1...')
      #
      # === response:
      # return a Fitbark::Data::Picture object.
      class UserPicture
        include Fitbark::Handler::V2::Base

        # :nodoc:
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

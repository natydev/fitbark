module Fitbark
  module Data
    # define user picture data structure
    class UserPicture < Hashie::Trash
      include Hashie::Extensions::IndifferentAccess

      property :base64, from: :data

      def bytes
        Base64.decode64(base64)
      end
    end
  end
end

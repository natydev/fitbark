module Fitbark
  module Data
    # define user picture data structure
    class UserPicture < OpenStruct
      include Fitbark::Data::Shared

      # property :data

      def base64
        data
      end

      def bytes
        Base64.decode64(data)
      end
    end
  end
end

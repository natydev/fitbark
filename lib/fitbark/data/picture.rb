module Fitbark
  module Data
    # Defines structure for picture data.
    #
    # Original attribute names from source API: 
    # - *data*
    class Picture < StrictOpenStruct
      include Fitbark::Data::Shared

      # an alias for *data* attribute
      def base64
        self[:data]
      end

      # decode data from base64
      def bytes
        Base64.decode64(data)
      end
    end
  end
end

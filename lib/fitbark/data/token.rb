module Fitbark
  module Data
    # Defines structure for access token.
    #
    # Original attribute names from source API: 

    # - *access_token*
    # - *token_type*
    # - *expires_in*
    # - *scope*
    class Token < StrictOpenStruct
      include Fitbark::Data::Shared

      # an alias for *access_token* source attribute
      def token
        self[:access_token]
      end

      # an alias for *token_type* source attribute
      def type
        self[:token_type]
      end

      # return Time of expiring based on *expires_in* source attribute
      def expires_at
        Time.now.utc + self[:expires_in].to_i
      end

      # return token's scopes as Array
      def scopes
        Array(self[:scope])
      end
    end
  end
end

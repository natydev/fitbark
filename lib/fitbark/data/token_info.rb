module Fitbark
  module Data
    # Defines structure for access token informations.
    #
    # Original attribute names from source API: 

    # - *resource_owner_id*
    # - *scopes*
    # - *expires_in_seconds*
    # - *application*
    class TokenInfo < StrictOpenStruct
      include Fitbark::Data::Shared

      # Defines structure for Application data inside TokenInfo
      class Application < StrictOpenStruct
        include Fitbark::Data::Shared
      end

      # return Time of expiring based on *expires_in_seconds* source attribute
      def expires_at
        Time.now.utc + self[:expires_in_seconds].to_i
      end
      # application as object kind Fitbark::Data::TokenInfo::Application
      def application
        Application.new self[:application]
      end
    end
  end
end

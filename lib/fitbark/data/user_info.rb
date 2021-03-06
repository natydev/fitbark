module Fitbark
  module Data
    # Defines structure for user's informations.
    #
    # Original attribute names from source API:  
    # - *slug*
    # - *slug*
    # - *username*
    # - *name*
    # - *first_name*
    # - *last_name*
    # - *picture_hash*
    class UserInfo < StrictOpenStruct
      include Fitbark::Data::Shared

      # an alias for source *username* attribute
      def email
        self[:username]
      end

      # an alias for source *name* attribute
      def fullname
        self[:name]
      end
    end
  end
end

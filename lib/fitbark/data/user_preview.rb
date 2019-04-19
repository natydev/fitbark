module Fitbark
  module Data
    # Defines structure for dog relation between user.
    #
    # Original attribute names from source API: 
    # - *slug*  
    # - *username*  
    # - *name*  
    # - *first_name*  
    # - *last_name*   
    class UserPreview < StrictOpenStruct
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

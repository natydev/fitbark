module Fitbark
  module Data
    # Defines structure for dog relation between user.
    #
    # Original attribute names from source API: 
    # - *id*
    # - *date*
    # - *dog_slug*  
    # - *status*  
    # - *user*
    class DogRelation < StrictOpenStruct
      include Fitbark::Data::Shared

      # user as object kind Fitbark::Data::UserPreview
      def user
        Fitbark::Data::UserPreview.new(self[:user])
      end

      # parse source String value into Date for *date* attribute
      def date
        date_parser(self[:date])
      end

      alias related_on date
    end
  end
end

module Fitbark
  module Data
    # Defines structure for user relation between a dog.
    #
    # Original attribute names from source API: 
    # - *id*
    # - *date*
    # - *status*  
    # - *dog* 
    class UserRelation < StrictOpenStruct
      include Fitbark::Data::Shared

      # dog as object kind Fitbark::Data::DogInfo
      def dog
        Fitbark::Data::DogInfo.new(self[:dog])
      end

      # parse source String value into Date for *date* attribute
      def date
        date_parser(self[:date])
      end

      alias related_on date
    end
  end
end

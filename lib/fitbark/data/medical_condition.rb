module Fitbark
  module Data
    # Defines structure for dog medical condition.
    #
    # Original attribute names from source API: 
    # - *id*
    # - *name*
    class MedicalCondition < StrictOpenStruct
      include Fitbark::Data::Shared
    end
  end
end

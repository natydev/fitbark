module Fitbark
  module Data
    # Defines structure for dog's breed data.
    #
    # Original attribute names from source API:  
    # - *id*,
    # - *name*
    class Breed < StrictOpenStruct
      include Fitbark::Data::Shared
    end
  end
end

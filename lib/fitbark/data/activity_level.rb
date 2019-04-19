module Fitbark
  module Data
    # Defines structure for dog's activity data.
    #
    # Original attribute names from source API:  
    # - *min_play*,
    # - *min_active*
    # - *min_rest*
    class ActivityLevel < StrictOpenStruct
      include Fitbark::Data::Shared

      # an alias for *min_play* attribute
      def minutes_playing
        self[:min_play]
      end

      # an alias for *min_active* attribute
      def minutes_active
        self[:min_active]
      end

      # an alias for *min_rest* attribute
      def minutes_resting
        self[:min_rest]
      end
    end
  end
end

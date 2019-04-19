module Fitbark
  module Data
    # Defines structure for dog's informations.
    #
    # Original attribute names from source API:  
    # - *slug*
    # - *name*
    # - *bluetooth_id*
    # - *activity_value*
    # - *birth*
    # - *breed1*
    # - *breed2*
    # - *gender*
    # - *weight*
    # - *weight_unit*
    # - *country*
    # - *zip*
    # - *tzoffset*
    # - *tzname*
    # - *min_play*
    # - *min_active*
    # - *min_rest*
    # - *medical_conditions*
    # - *hourly_average*
    # - *picture_hash*
    # - *neutered*
    # - *last_min_time*
    # - *last_min_activity*
    # - *daily_goal*
    # - *battery_level*
    # - *last_sync*
    class DogInfo < StrictOpenStruct
      include Fitbark::Data::Shared

      # parse source String value into Date for *birth* attribute
      def birth
        date_parser(self[:birth])
      end

      alias birth_on birth

      # an alias for source *gender* attribute
      def sex
        self[:gender]
      end

      # an alias for *zip* attribute
      def postal_code
        self[:zip]
      end

      # an alias for *zip* attribute
      def zip_code
        self[:zip]
      end

      # an alias for *min_play* attribute
      def today_minutes_playing
        self[:min_play]
      end

      # an alias for *min_active* attribute
      def today_minutes_active
        self[:min_active]
      end

      # an alias for *min_rest* attribute
      def today_minutes_resting
        self[:min_rest]
      end

      # parse String value into Time for *last_min_time* attribute
      def last_min_time
        time_parser(self[:last_min_time])
      end

      alias last_minute_at last_min_time

      # parse String value into Time for *last_min_activity* attribute
      def last_minute_activity
        self[:last_min_activity]
      end

      # an alias for *activity_value* attribute
      def today_activity_points
        self[:activity_value]
      end

      # parse String value into Time for *last_sync* attribute
      def last_sync
        time_parser(self[:last_sync])
      end

      alias sync_at last_sync

      # first breed according to Fitbark::Data::Breed
      def breed1
        init_breed(self[:breed1])
      end

      alias first_breed breed1

      # second breed according to Fitbark::Data::Breed
      def breed2
        init_breed(self[:breed2])
      end

      alias second_breed breed2

      # an array of Fitbark::Data::MedicalCondition objects
      def medical_conditions
        self[:medical_conditions].map do |mc|
          init_medical_condition(mc)
        end
      end
    end
  end
end

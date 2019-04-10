module Fitbark
  module Data
    # define user info data structure
    class DogInfo < OpenStruct
      include Fitbark::Data::Shared
      # property :slug
      # property :name
      # property :bluetooth_id
      # property :activity_value
      # property :birth
      # property :breed1
      # property :breed2
      # property :gender
      # property :weight
      # property :weight_unit
      # property :country
      # property :zip_code
      # property :tzoffset
      # property :tzname
      # property :min_play
      # property :min_active
      # property :min_rest
      # property :medical_conditions
      # property :hourly_average
      # property :picture_hash
      # property :neutered
      # property :last_min_time
      # property :last_min_activity
      # property :daily_goal
      # property :battery_level
      # property :last_sync

      def breed1
        init_breed(self[:breed1])
      end

      def breed2
        init_breed(self[:breed2])
      end

      def medical_conditions
        self[:medical_conditions].map do |mc|
          init_medical_condition(mc)
        end
      end

      def birth
        date_parser(self[:birth])
      end

      def last_min_time
        time_parser(self[:last_min_time])
      end

      def last_sync
        time_parser(self[:last_sync])
      end

    end
  end
end

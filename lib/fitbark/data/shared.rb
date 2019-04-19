module Fitbark
  module Data
    # Provides general behaviour for data classes.
    module Shared
      def self.included(base)
        base.send :extend, ClassMethods
      end

      module ClassMethods
      end

      private
      
      def time_parser(attr)
        Time.parse(attr.to_s)
      rescue ArgumentError
        nil
      end

      def date_parser(attr)
        Date.parse(attr.to_s)
      rescue ArgumentError
        nil
      end

      def init_breed(attr)
        Fitbark::Data::Breed.new(attr)
      end

      def init_medical_condition(attr)
        Fitbark::Data::MedicalCondition.new(attr)
      end
    end
  end
end

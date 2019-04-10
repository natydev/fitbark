module Fitbark
  module Data
    # define user info data structure
    class UserRelation < OpenStruct
      include Fitbark::Data::Shared

      def dog
        Fitbark::Data::DogPreview.new(self[:dog])
      end

      def date
        time_parser(self[:date])
      end
    end
  end
end

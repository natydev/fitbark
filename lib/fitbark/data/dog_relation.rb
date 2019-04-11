module Fitbark
  module Data
    # define dog info data structure
    class DogRelation < OpenStruct
      include Fitbark::Data::Shared

      def user
        Fitbark::Data::DogRelation::User.new(self[:user])
      end

      def date
        time_parser(self[:date])
      end

      class User < self; end
    end
  end
end

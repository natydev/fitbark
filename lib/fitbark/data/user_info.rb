module Fitbark
  module Data
    # define user info data structure
    class UserInfo < OpenStruct
      include Fitbark::Data::Shared

      # property :slug
      # property :username
      # property :name
      # property :first_name
      # property :last_name
      # property :picture_hash

      def email
        username
      end

      def fullname
        name
      end
    end
  end
end

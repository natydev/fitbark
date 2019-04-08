module Fitbark
  module Data
    # define user info data structure
    class UserInfo < Hashie::Trash
      include Hashie::Extensions::IndifferentAccess

      property :slug
      property :username
      property :name
      property :first_name
      property :last_name
      property :picture_hash

      alias email username
      alias fullname name
    end
  end
end

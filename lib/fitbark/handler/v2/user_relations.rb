module Fitbark
  module Handler
    module V2
      # = \#user_relations
      # Fitbark::Handler::V2::DogRelations define method *user_relations*
      # inside Client object
      #
      # === params (key/value):
      #
      # - *dog_slug*: slug ID relative to dog (String)
      #
      # example usage:
      #   client = Client.new(token: 'a5b3f8...')
      #   client.user_relations(dog_slug: 'v4s1...')
      #
      # === response:
      # An array of Fitbark::Data::DogRelation objects.
      class UserRelations
        include Fitbark::Handler::V2::Base

        # :nodoc:
        # https://app.fitbark.com/api/v2/user_relations/{dog_slug}
        def response
          json_response['user_relation'].map do |rel|
            Fitbark::Data::DogRelation.new(rel)
          end
        end

        private

        def raw_response
          connection(fragment: "user_relations/#{opts[:dog_slug]}").body
        end
      end
    end
  end
end

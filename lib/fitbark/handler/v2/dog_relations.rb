module Fitbark
  module Handler
    module V2
      # = \#dog_relations
      # Fitbark::Handler::V2::DogRelations define method *dog_relations*
      # inside Client object
      #
      # === params (key/value):
      #
      # - no params required
      #
      # example usage:
      #   client = Client.new(token: 'a5b3f8...')
      #   client.dog_relations
      #
      # === response:
      # An array of Fitbark::Data::UserRelation objects.
      class DogRelations
        include Fitbark::Handler::V2::Base

        # :nodoc:
        # https://app.fitbark.com/api/v2/dog_relations
        def response
          json_response['dog_relations'].map do |rel|
            Fitbark::Data::UserRelation.new(rel)
          end
        end

        private

        def raw_response
          connection(fragment: 'dog_relations').body
        end
      end
    end
  end
end

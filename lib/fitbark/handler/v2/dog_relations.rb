module Fitbark
  module Handler
    module V2
      # Fitbark::Handler::V2::User class
      class DogRelations
        include Fitbark::Handler::V2::Base

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

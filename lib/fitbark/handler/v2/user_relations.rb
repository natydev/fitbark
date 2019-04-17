module Fitbark
  module Handler
    module V2
      # Fitbark::Handler::V2::UserRelations class
      class UserRelations
        include Fitbark::Handler::V2::Base

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

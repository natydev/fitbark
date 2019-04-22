module Fitbark
  module Handler
    module V2
      # = \#friend_dogs
      # Fitbark::Handler::V2::FriendDogs defines method *friend_dogs*
      # inside Client object, it retrieve all dogs having friendship 
      # relation with logged user
      #
      # === params (key/value):
      #
      # - no params required
      #
      # example usage:
      #   client = Client.new(token: 'a5b3f8...')
      #   client.friend_dogs
      #
      # === response:
      # An array of Fitbark::Data::DogInfo objects.
      class FriendDogs
        include Fitbark::Handler::V2::Base

        # :nodoc:
        # https://app.fitbark.com/api/v2/dog_relations
        def response
          json_response['dog_relations'].
          select{|h| h['status'].upcase == 'FRIEND'}.map do |rel|
            Fitbark::Data::DogInfo.new(rel['dog'])
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

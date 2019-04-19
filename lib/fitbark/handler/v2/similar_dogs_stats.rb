module Fitbark
  module Handler
    module V2
      # = \#similar_dogs_stats
      # Fitbark::Handler::V2::SimilarDogsStats define method *similar_dogs_stats*
      # inside Client object
      #
      # === params (key/value):
      #
      # - *dog_slug*: slug ID relative to dog's activities (String)
      #
      # example usage:
      #   client = Client.new(token: 'a5b3f8...')
      #   client.similar_dogs_stats(dog_slug: 'v4s1...')
      #
      # === response:
      # return a Fitbark::Data::SimilarDogsStat object.
      class SimilarDogsStats
        include Fitbark::Handler::V2::Base

        # :nodoc:
        # https://app.fitbark.com/api/v2/similar_dogs_stats
        def response
          Fitbark::Data::SimilarDogsStat
            .new(json_response['similar_dogs_stats'])
        end

        private

        def raw_response
          connection(verb: :post, fragment: 'similar_dogs_stats',
                     params: { 'slug' => opts[:dog_slug] }).body
        end
      end
    end
  end
end

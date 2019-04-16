module Fitbark
  module Handler
    module V2
      # Fitbark::Handler::V2::SimilarDogsStats class
      class SimilarDogsStats
        include Fitbark::Handler::V2::Base

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

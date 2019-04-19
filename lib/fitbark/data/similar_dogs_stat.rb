module Fitbark
  module Data
    # Defines structure for similar dogs stats.
    #
    # Original attribute names from source API: 

    # - *this_best_daily_activity*
    # - *this_best_week_activity*
    # - *this_current_goals_streak*
    # - *this_best_goals_streak*
    # - *this_average_daily_activity*
    # - *median_same_age_weight_daily_activity*
    # - *this_average_daily_rest_minutes*
    # - *median_same_age_weight_range_dogs_daily_rest_minutes*
    # - *median_all_dogs_daily_activity*
    # - *median_same_breed_daily_activity*
    class SimilarDogsStat < StrictOpenStruct
      include Fitbark::Data::Shared

    end
  end
end

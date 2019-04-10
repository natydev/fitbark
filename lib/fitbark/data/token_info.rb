module Fitbark
  module Data
    # define TokenInfo data structure
    class TokenInfo < OpenStruct
      include Fitbark::Data::Shared

      # define Application data inside TokenInfo
      class Application < OpenStruct
        include Fitbark::Data::Shared
      end

      def expires_at
        Time.now.utc + self[:expires_in].to_i
      end

      def application
        Application.new self[:application]
      end
    end
  end
end

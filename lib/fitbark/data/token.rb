module Fitbark
  module Data
    # define Token data structure
    class Token < OpenStruct
      include Fitbark::Data::Shared

      def token
        self[:access_token]
      end

      def type
        self[:token_type]
      end

      def expires_at
        Time.now.utc + self[:expires_in].to_i
      end

      def scopes
        Array(self[:scope])
      end
    end
  end
end

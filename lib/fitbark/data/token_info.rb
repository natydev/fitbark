module Fitbark
  module Data
    # define TokenInfo data structure
    class TokenInfo < Hashie::Trash
      include Hashie::Extensions::IndifferentAccess
      include Hashie::Extensions::Coercion
      # Application data inside TokenInfo
      class Application < Hashie::Trash
        include Hashie::Extensions::IndifferentAccess
        property :uid
      end

      property :resource_owner_id
      property :scopes
      property :expires_at, from: :expires_in_seconds,
                            with: ->(seconds) { Time.now.utc + seconds }
      property :application
      coerce_key :application, Application
    end
  end
end

module Fitbark
  module Data
    # define Token data structure
    class Token < Hashie::Trash
      include Hashie::Extensions::IndifferentAccess

      property :token, from: :access_token
      property :type, from: :token_type
      property :expires_at, from: :expires_in,
                            with: ->(seconds) { Time.now.utc + seconds }
      property :scopes, from: :scope, with: ->(scope) { Array(scope) }
    end
  end
end

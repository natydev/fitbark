module RspecHelpers
  include Fitbark::Constants

  def random_token
    SecureRandom.hex(30)
  end

  def api_uri_request
    Addressable::URI.new(host: API_HOST, scheme: API_SCHEME,
                         path: API_SUBHOST).to_s
  end

  def api_headers_request(token)
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{token}"
    }
  end

  def json_response(key)
    File.open("spec/fixtures/#{key}.js", 'rb').read
  end

  def stub_webmock_error(fragment)
    stub_request(:get, "#{api_uri_request}/#{fragment}")
      .with(headers: api_headers_request(token))
      .to_return(status: 500, body:
        'something was wrong')
  end
end

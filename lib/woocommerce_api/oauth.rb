require "digest/sha1"
require "cgi"
require "base64"
require "openssl"

module WooCommerce
  class OAuth

    def initialize url, method, version, consumer_key, consumer_secret
      @url = url
      @method = method.upcase
      @version = version
      @consumer_key = consumer_key
      @consumer_secret = consumer_secret
    end

    # Public: Get OAuth params
    #
    # Returns the params Hash.
    def get_oauth_params
      params = {}
      params[:oauth_consumer_key] = @consumer_key
      params[:oauth_nonce] = Digest::SHA1.hexdigest(Time.new.to_s)
      params[:oauth_signature_method] = "HMAC-SHA256"
      params[:oauth_timestamp] = Time.new.to_i
      params[:oauth_signature] = generate_oauth_signature(params)

      params
    end

    protected

    # Internal: Generate the OAuth Signature
    #
    # params - A Hash with the OAuth params.
    #
    # Returns the oauth signature String.
    def generate_oauth_signature(params)
        base_request_uri = CGI::escape(@url.to_s)
        query_params = []
        params.each do |key, value|
          query_params.push(CGI::escape(key.to_s) + "%3D" + CGI::escape(value.to_s))
        end

        query_string = query_params.join("%26")

        string_to_sign = "#{@method}&#{base_request_uri}&#{query_string}"

        if @version == "v3"
          consumer_secret = "#{@consumer_secret}&"
        else
          consumer_secret = @consumer_secret
        end

        return Base64.strict_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), consumer_secret, string_to_sign))
    end
  end
end

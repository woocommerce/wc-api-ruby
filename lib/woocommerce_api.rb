require "httparty"
require "json"
require "woocommerce_api/version"

module WooCommerce
  class API
    include HTTParty

    def initialize url, consumer_key, consumer_secret, version = "v3"
      @url = url
      @consumer_key = consumer_key
      @consumer_secret = consumer_secret
      @version = version
      @is_ssl = @url.start_with? "https"
    end

    # Public: GET requests.
    #
    # endpoint - A String naming the request endpoint.
    #
    # Returns the request Hash.
    def get endpoint
      self.class.get get_url(endpoint), request_options
    end

    # Public: POST requests.
    #
    # endpoint - A String naming the request endpoint.
    # data     - The Hash data for the request.
    #
    # Returns the request Hash.
    def post endpoint, data
      self.class.post get_url(endpoint), request_options(data)
    end

    # Public: PUT requests.
    #
    # endpoint - A String naming the request endpoint.
    # data     - The Hash data for the request.
    #
    # Returns the request Hash.
    def put endpoint, data
      self.class.put get_url(endpoint), request_options(data)
    end

    # Public: DELETE requests.
    #
    # endpoint - A String naming the request endpoint.
    #
    # Returns the request Hash.
    def delete endpoint
      self.class.delete get_url(endpoint), request_options
    end

    protected

    # Internal: Get URL for requests
    #
    # endpoint - A String naming the request endpoint.
    #
    # Returns the endpoint String.
    def get_url endpoint
      url = @url
      if !url.end_with? "/"
        url = "#{url}/"
      end

      "#{url}wc-api/#{@version}/#{endpoint}"
    end

    # Internal: Requests default options.
    #
    # Returns the options Hash.
    def request_options data = nil
      options = {
        format: :json,
        verify: false,
        headers: {
          "User-Agent" => "WooCommerce API Client-Ruby/#{WooCommerce::VERSION}",
          "Content-Type" => "application/json;charset=utf-8",
          "Accept" => "application/json"
        }
      }

      if @is_ssl
        options.merge!({
          basic_auth: {
            username: @consumer_key,
            password: @consumer_secret
          }
        })
      end

      if data
        options.merge!({
          body: data.to_json
        })
      end

      options
    end

  end
end

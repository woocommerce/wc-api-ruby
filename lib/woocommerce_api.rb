require "httparty"
require "json"

require "woocommerce_api/oauth"
require "woocommerce_api/version"

module WooCommerce
  class API

    def initialize url, consumer_key, consumer_secret, args = {}
      # Required args
      @url = url
      @consumer_key = consumer_key
      @consumer_secret = consumer_secret

      # Optional args
      defaults = {version: "v3", verify_ssl: true}
      args = defaults.merge(args)

      @version = args[:version]
      @verify_ssl = args[:verify_ssl] == true
      @signature_method = args[:signature_method]

      # Internal args
      @is_ssl = @url.start_with? "https"
    end

    # Public: GET requests.
    #
    # endpoint - A String naming the request endpoint.
    #
    # Returns the request Hash.
    def get endpoint
      do_request :get, endpoint
    end

    # Public: POST requests.
    #
    # endpoint - A String naming the request endpoint.
    # data     - The Hash data for the request.
    #
    # Returns the request Hash.
    def post endpoint, data
      do_request :post, endpoint, data
    end

    # Public: PUT requests.
    #
    # endpoint - A String naming the request endpoint.
    # data     - The Hash data for the request.
    #
    # Returns the request Hash.
    def put endpoint, data
      do_request :put, endpoint, data
    end

    # Public: DELETE requests.
    #
    # endpoint - A String naming the request endpoint.
    #
    # Returns the request Hash.
    def delete endpoint
      do_request :delete, endpoint
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
    # method   - A String naming the request method
    # endpoint - A String naming the request endpoint.
    # data     - The Hash data for the request.
    #
    # Returns the response in JSON String.
    def do_request method, endpoint, data = nil
      url = get_url endpoint

      options = {
        format: :json,
        verify: @verify_ssl,
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
      else
        url = oauth_url(url, method)
      end

      if data
        options.merge!({
          body: data.to_json
        })
      end

      HTTParty.send method, url, options
    end

    # Internal: Generates an oauth url given current settings
    #
    # url    - A String naming the current request url
    # method - The HTTP verb of the request
    #
    # Returns a url to be used for the query.
    def oauth_url(url, method)
      oauth = WooCommerce::OAuth.new(url,
                                     method,
                                     @version,
                                     @consumer_key,
                                     @consumer_secret,
                                     @signature_method)
      oauth.get_oauth_url
    end
  end
end

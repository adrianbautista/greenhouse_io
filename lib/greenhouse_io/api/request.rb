require 'uri'
require 'net/http'
require 'json'
require 'httparty'

module GreenhouseIo
  class Request
    include HTTMultiParty

    # base_uri 'https://harvest.greenhouse.io/v1'

    def base_uri(uri)
      base_uri = uri ? uri : 'https://harvest.greenhouse.io/v1'
    end

    attr_accessor :api_token

    PERMITTED_OPTIONS = [:page, :per_page, :job_id]

    def initialize(api_token = nil)
      @api_token = api_token || GreenhouseIo.configuration.api_token
    end

    private

    def get_from_harvest_api(url, options = {})
      response = self.class.get(url, query: permitted_options(options), basic_auth: auth_details)
      handle_response(response)
    end

    def post_to_harvest_api(url, body, headers)
      response = self.class.post(url, body: JSON.dump(body), headers: headers, basic_auth: auth_details)
      handle_response(response)
    end

    def patch_to_harvest_api(url, body, headers)
      uri = URI.parse(base_uri)
      request = Net::HTTP::Patch.new(uri)
      headers.each { |key, value| request[key] = value }
      request["Authorization"] = "Basic #{Base64.strict_encode64("#{api_token}:")}"
      request.body = JSON.dump(body)
      req_options = { use_ssl: uri.scheme == "https"}
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) { |http| http.request(request)}

      handle_response(response)
    end

    # def put_to_harvest_api(url, body, headers)
    #   response = self.class.put(url, body: JSON.dump(body), headers: headers, basic_auth: auth_details)
    #   handle_response(response)
    # end

    # def patch_to_harvest_api(url, body, headers)
    #   response = self.class.patch(url, body: JSON.dump(body), headers: headers, basic_auth: auth_details)
    #   handle_response(response)
    # end

    # def delete_from_harvest_api(url, body, headers)
    #   response = self.class.delete(url, body: JSON.dump(body), headers: headers, basic_auth: auth_details)
    #   handle_response(response)
    # end

    def auth_details
      { username: @api_token, password: '' }
    end

    def handle_response(response)
      set_headers_info(response.headers)
      raise GreenhouseIo::Error.new(response.code) unless response.code.between?(200, 204)
      response.parsed_response
    end

    def set_headers_info(headers)
      self.rate_limit = headers['x-ratelimit-limit'].to_i
      self.rate_limit_remaining = headers['x-ratelimit-remaining'].to_i
      self.link = headers['link'].to_s
    end

    def permitted_options(options)
      options.select { |key, _value| PERMITTED_OPTIONS.include? key }
    end

    def path_id(id = nil)
      "/#{id}" unless id.nil?
    end

    def paginated_get(url, params = {}, endpoint = nil)
      results = []
      page = 1

      loop do
        params[:page] = page
        p "fetching page #{page}"

        response = get_from_harvest_api(url, params, endpoint)
        results.concat(response)

        page+=1
        break if response.size < 100
      end

      results
    end
  end
end

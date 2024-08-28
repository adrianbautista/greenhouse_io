require 'uri'
require 'net/http'
require 'json'
require 'httmultiparty'

require_relative '../api'
require_relative 'modules/applications'
require_relative 'modules/candidates'
require_relative 'modules/custom_fields'
require_relative 'modules/jobs'
require_relative 'modules/offers'
require_relative 'modules/prospects'
require_relative 'modules/scorecards'
require_relative 'modules/tags'
require_relative 'modules/users'
require_relative 'modules/sources'

module GreenhouseIo
  class Client
    include HTTMultiParty
    include GreenhouseIo::API
    include GreenhouseIo::Applications
    include GreenhouseIo::Candidates
    include GreenhouseIo::CustomFields
    include GreenhouseIo::Jobs
    include GreenhouseIo::Offers
    include GreenhouseIo::Prospects
    include GreenhouseIo::Scorecards
    include GreenhouseIo::Tags
    include GreenhouseIo::Users
    include GreenhouseIo::Sources

    attr_accessor :api_token, :rate_limit, :rate_limit_remaining, :link

    def initialize(api_token = nil)
      @api_token = api_token || GreenhouseIo.configuration.api_token
    end

    PERMITTED_OPTIONS = [:page, :per_page, :job_id, :updated_after, :created_after]
    PERMITTED_OPTIONS_PER_ENDPOINT = {
      'candidates' => [:email, :job_id],
      'jobs' => [:status, :department_id, :requisition_id],
      'job_posts' => [:active, :live],
      'applications' => [:last_activity_after, :status, :job_id],
    }

    # Set the default base URI
    base_uri 'https://harvest.greenhouse.io/v1'

    # Define a method to change the base_uri
    def self.set_base_uri(uri)
      self.base_uri uri
    end

    private

    def default_headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    end

    def get_from_harvest_api(url, options = {})
      puts "GET request from URL: #{self.class.base_uri + url}, OPTIONS: #{options}"
      response = self.class.get(url, query: permitted_options(options), basic_auth: auth_details)
      handle_response(response)
    end

    def post_to_harvest_api(url, body, headers = {})
      headers = default_headers.merge(headers)
      puts "POST request to URL: #{self.class.base_uri + url}, BODY: #{body}, HEADER: #{headers}"
      response = self.class.post(url, body: JSON.dump(body), headers: headers, basic_auth: auth_details)
      handle_response(response)
    end

    def put_to_harvest_api(url, body, headers = {})
      headers = default_headers.merge(headers)
      puts "PUT request to URL: #{self.class.base_uri + url}, BODY: #{body}, HEADER: #{headers}"
      response = self.class.put(url, body: JSON.dump(body), headers: headers, basic_auth: auth_details)
      handle_response(response)
    end

    def patch_to_harvest_api(url, body, headers = {})
      headers = default_headers.merge(headers)
      puts "PATCH request to URL: #{self.class.base_uri + url}, BODY: #{body}, HEADER: #{headers}"
      response = self.class.patch(url, body: JSON.dump(body), headers: headers, basic_auth: auth_details)
      handle_response(response)
    end

    def delete_from_harvest_api(url, body)
      puts "DELETE request to URL: #{self.class.base_uri + url}, BODY: #{body}"
      response = self.class.delete(url, body: JSON.dump(body), headers: default_headers, basic_auth: auth_details)
      handle_response(response)
    end

    def auth_details
      { username: @api_token }
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
      return nil if options.empty?
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
        p "fetching page #{page} for url: #{url}"

        response = get_from_harvest_api(url, params)
        results.concat(response)

        page += 1
        break if response.size < 100
      end

      results
    end
  end
end

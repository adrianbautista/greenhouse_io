module GreenhouseIo
  module Prospects

    def create_prospect(prospect_hash = {}, on_behalf_of)
      post_to_harvest_api(
        "/prospects",
        prospect_hash,
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    def list_prospect_pools(options = {})
      paginated_get("/prospect_pools", options, 'prospect_pools')
    end

    def list_prospect_pool(prospect_id = nil, options = {})
      get_from_harvest_api("/prospect_pools#{path_id(prospect_id)}", options)
    end
  end
end

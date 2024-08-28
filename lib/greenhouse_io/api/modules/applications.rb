module GreenhouseIo
  module Applications

    def applications(options = {})
      paginated_get("/applications", options, 'applications')
    end

    def application(id = nil, options = {})
      get_from_harvest_api("/applications#{path_id(id)}", options)
    end

    # Add an application to a candidate/prospect
    # POST https://harvest.greenhouse.io/v1/candidates/{id}/applications
    def add_application_to_candidate(candidate_id = nil, application_hash = {}, on_behalf_of)
      post_to_harvest_api(
        "/candidates#{path_id(candidate_id)}/applications",
        application_hash,
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    # Convert a prospect to a candidate
    # PATCH https://harvest.greenhouse.io/v1/applications/{id}/convert_prospect
    def convert_prospect_to_candidate(application_id = nil, application_hash = {}, on_behalf_of)
      patch_to_harvest_api(
        "/applications#{path_id(application_id)}/convert_prospect",
        application_hash,
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    # Update an application
    # PATCH https://harvest.greenhouse.io/v1/applications/{id}
    def update_application(application_id = nil, application_hash = {}, on_behalf_of)
      patch_to_harvest_api(
        "/applications#{path_id(application_id)}",
        application_hash,
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    # delete application
    # DELETE https://harvest.greenhouse.io/v1/applications/{id}
    def delete_application(id = nil)
      delete_from_harvest_api("/applications#{path_id(id)}", {})
    end
  end
end

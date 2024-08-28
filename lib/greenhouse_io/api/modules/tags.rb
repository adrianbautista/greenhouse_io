module GreenhouseIo
  module Tags

    # get all the tags from a candidate
    # GET https://harvest.greenhouse.io/v1/tags/candidate
    def tags(options = {})
      paginated_get("/tags/candidate", options, 'tags')
    end

    # get the tags associated with a specific candidate
    # GET https://harvest.greenhouse.io/v1/candidates/{id}/tags
    def candidate_tags(candidate_id= nil, options = {})
      get_from_harvest_api("/candidates#{path_id(candidate_id)}/tags", options)
    end

    # add new tag value
    # POST https://harvest.greenhouse.io/v1/tags/candidate
    def create_tags(tag_hash, on_behalf_of)
      post_to_harvest_api(
        "/tags/candidate",
        tag_hash,
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    # apply a tag to a specific candidate
    # PUT https://harvest.greenhouse.io/v1/candidates/{candidate_id}/tags/{tag_id}
    def create_candidate_tags(candidate_id = nil, tag_id = nil, tag_hash, on_behalf_of)
      put_to_harvest_api(
        "/candidates#{path_id(candidate_id)}/tags#{path_id(tag_id)}",
        tag_hash,
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    # delete specific tag from candidate section
    # DELETE 'https://harvest.greenhouse.io/v1/tags/candidate/{tag id}
    def delete_tags(tag_id = nil)
      delete_from_harvest_api("/tags/candidate#{path_id(tag_id)}", {})
    end
  end
end

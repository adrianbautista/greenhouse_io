module GreenhouseIo
  module Candidates

    def candidates(options = {})
      paginated_get("/candidates", options, 'candidates')
    end

    def candidate(candidate_id = nil, options = {})
      get_from_harvest_api("/candidates#{path_id(candidate_id)}", options)
    end

    def candidate_activity_feed(candidate_id = nil, options = {})
      get_from_harvest_api("/candidates#{path_id(candidate_id)}/activity_feed", options)
    end

    def create_candidate(candidate_hash = {}, on_behalf_of)
      post_to_harvest_api(
        "/candidates",
        candidate_hash,
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    def update_candidate(candidate_id, candidate_hash = {}, on_behalf_of)
      patch_to_harvest_api(
        "/candidates#{path_id(candidate_id)}",
        candidate_hash,
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    def create_candidate_education(candidate_id = nil, education_hash = {}, on_behalf_of)
      post_to_harvest_api(
        "/candidates#{path_id(candidate_id)}/educations",
        education_hash,
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    def create_candidate_note(candidate_id, note_hash = {}, on_behalf_of)
      post_to_harvest_api(
        "/candidates#{path_id(candidate_id)}/activity_feed/notes",
        note_hash,
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    # DELETE https://harvest.greenhouse.io/v1/candidates/{candidate_id}/educations/{education_id}
    def remove_candidate_educaation(candidate_id = nil, education_id = nil)
      delete_from_harvest_api("/candidates#{path_id(candidates)}/educations#{path_id(education_id)}", {})
    end
  end
end

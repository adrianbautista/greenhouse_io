module GreenhouseIo
  module CustomFields

    # Retrieve all custom fields
    # GET https://harvest.greenhouse.io/v1/custom_fields
    def all_custom_fields(options = {})
      paginated_get("/custom_fields", options, 'custom_fields')
    end

    # Retrieve a specific custom field
    # GET https://harvest.greenhouse.io/v1/custom_fields/{custom_field_id}
    def custom_field(custom_field_id = nil, options = {})
      get_from_harvest_api("/custom_fields#{path_id(custom_field_id)}", options)
    end

    # Update a specific custom field
    # PATCH https://harvest.greenhouse.io/v1/custom_fields/{custom_field_id}
    def update_custom_field(custom_field_id = nil, custom_field_hash)
      patch_to_harvest_api("/custom_fields#{path_id(custom_field_id)}", custom_common_field_hash, {})
    end

    # Create a new custom field
    # POST https://harvest.greenhouse.io/v1/custom_fields
    def create_custom_field(custom_field_hash = {}, on_behalf_of)
      post_to_harvest_api(
        "/custom_fields",
        custom_field_hash,
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    # Delete a specific custom field
    # DELETE https://harvest.greenhouse.io/v1/custom_fields/{custom_field_id}
    def delete_custom_field(custom_field_id = nil)
      delete_from_harvest_api("/custom_fields#{path_id(custom_field_id)}", {})
    end
  end
end

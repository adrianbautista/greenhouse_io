module GreenhouseIo
  module Users

    # get all the Users from Greenhouse system
    # GET https://harvest.greenhouse.io/v1/users
    def users(options = {})
      paginated_get("/users", options, 'users')
    end

    # get the user associated with a specific id
    # GET https://harvest.greenhouse.io/v1/users/{id}
    def user(user_id= nil, options = {})
      get_from_harvest_api("/users#{path_id(user_id)}", options)
    end
  end
end

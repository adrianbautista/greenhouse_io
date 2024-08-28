module GreenhouseIo
  module Sources
    def sources(options = {})
      paginated_get("/sources", options, 'sources')
    end
  end
end

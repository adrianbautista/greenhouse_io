module GreenhouseIo
  module Jobs

    def jobs(job_id = nil, options = {})
      get_from_harvest_api "/jobs#{path_id(job_id)}", options
    end

    def stages(job_id = nil, options = {})
      get_from_harvest_api "/jobs#{path_id(job_id)}/stages", options
    end

    def job_post(job_id = nil, options = {})
      get_from_harvest_api "/jobs#{path_id(job_id)}/job_post", options
    end
  end
end

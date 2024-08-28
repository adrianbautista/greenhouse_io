module GreenhouseIo
  module Offers

    def offers(offer_id = nil, options = {})
      get_from_harvest_api "/offers#{path_id(offer_id)}", options
    end

    def offers_for_application(offer_id = nil, options = {})
      get_from_harvest_api "/applications/#{offer_id}/offers", options
    end

    def current_offer_for_application(offer_id = nil, options = {})
      get_from_harvest_api "/applications/#{offer_id}/offers/current_offer", options
    end
  end
end

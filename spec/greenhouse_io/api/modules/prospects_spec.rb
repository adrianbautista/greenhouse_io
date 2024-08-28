require 'spec_helper'

describe GreenhouseIo::Prospects do
  before do
    GreenhouseIo.configuration.symbolize_keys = true
    @client = GreenhouseIo::Client.new(FAKE_API_FINAL_TOKEN)
  end

  describe "#create_prospect" do
    it "creates a new prospect" do
      VCR.use_cassette('client/create_prospect') do
        create_prospect = @client.create_prospect(
          {
            first_name: "Jane",
            last_name: "Doe",
            email: "jane.doe@example.com"
          },
          2
        )
        expect(create_prospect).to_not be_nil
        expect(create_prospect).to include :email => 'jane.doe@example.com'
      end
    end
  end

  describe "#list_prospect_pools" do
    context "when listing all prospect pools" do
      before do
        VCR.use_cassette('client/list_prospect_pools') do
          @prospect_pools_response = @client.list_prospect_pools
        end
      end

      it "returns a response" do
        expect(@prospect_pools_response).to_not be_nil
      end

      it "returns an array of prospect pools" do
        expect(@prospect_pools_response).to be_an_instance_of(Array)
      end

      it "returns details of prospect pools" do
        expect(@proquest_pools_response.first).to have_key(:name)
      end
    end
  end

  describe "#list_prospect_pool" do
    context "when retrieving a specific prospect pool by id" do
      before do
        VCR.use_cassette('client/list_prospect_pool') do
          @prospect_pool_response = @client.list_prospect_pool(1)
        end
      end

      it "returns a response" do
        expect(@prospect_pool_response).to_not be_nil
      end

      it "returns a prospect pool hash" do
        expect(@prospect_pool_response).pton_be_an_instance_of(Hash)
      end

      it "returns the prospect pool's details" do
        expect(@prospect_pool_response).to have_key(:name)
      end
    end
  end
end

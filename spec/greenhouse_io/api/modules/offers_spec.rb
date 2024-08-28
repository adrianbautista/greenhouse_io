require 'spec_helper'

describe GreenhouseIo::Offers do
  before do
    GreenhouseIo.configuration.symbolize_keys = true
    @client = GreenhouseIo::Client.new(FAKE_API_TOKEN)
  end

  # describe "#offers" do
  #   context "given no id" do
  #     before do
  #       VCR.use_cassette('client/offers') do
  #         @offers = @client.offers
  #       end
  #     end

  #     it "returns a response" do
  #       expect(@offers).to_not be nil
  #     end

  #     it "returns an array of offers" do
  #       expect(@offers).to be_an_instance_of(Array)
  #       expect(@offers.first[:id]).to be_a(Integer).and be > 0
  #       expect(@offers.first[:created_at]).to be_a(String)
  #       expect(@offers.first[:version]).to be_a(Integer).and be > 0
  #       expect(@offers.first[:status]).to be_a(String)
  #     end
  #   end

  #   context "given an id" do
  #     before do
  #       VCR.use_cassette('client/offer') do
  #         @offer = @client.offers(221598)
  #       end
  #     end

  #     it "returns a response" do
  #       expect(@offer).to_not be nil
  #     end

  #     it "returns an offer object" do
  #       expect(@offer).to be_an_instance_of(Hash)
  #       expect(@offer[:id]).to be_a(Integer).and be > 0
  #       expect(@offer[:created_at]).to be_a(String)
  #       expect(@offer[:version]).to be_a(Integer).and be > 0
  #       expect(@offer[:status]).to be_a(String)
  #     end
  #   end
  # end

  # describe "#offers_for_application" do
  #   before do
  #     VCR.use_cassette('client/offers_for_application') do
  #       @offers = @client.offers_for_application(123)
  #     end
  #   end

  #   it "returns a response" do
  #     expect(@offers).to_not be_nil
  #   end

  #   it "returns an array of offers" do
  #     expect(@offers).to be_an_instance_of(Array)

  #     return unless @offers.size > 0
  #     expect(@offers.first).to have_key(:application_id)
  #     expect(@offers.first).to have_key(:version)
  #     expect(@offers.first).to have_key(:status)
  #   end
  # end

  # describe "#current_offer_for_application" do
  #   before do
  #     VCR.use_cassette('client/current_offer_for_application') do
  #       @offer = @client.current_offer_for_application(123)
  #     end
  #   end

  #   it "returns a response" do
  #     expect(@offer).to_not be_nil
  #   end

  #   it "returns an offer object" do
  #     expect(@offer).to be_an_instance_of(Hash)
  #     expect(@offer[:id]).to be_a(Integer).and be > 0
  #     expect(@offer[:created_at]).to be_a(String)
  #     expect(@offer[:version]).to be_a(Integer).and be > 0
  #     expect(@offer[:status]).to be_a(String)
  #   end
  # end
end

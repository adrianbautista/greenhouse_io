require 'spec_helper'

describe GreenhouseIo::ActivityFeeds do
  before do
    GreenhouseIo.configuration.symbolize_keys = true
    @client = GreenhouseIo::Client.new(FAKE_API_TOKEN)
  end

  describe '#candidate_activity_feed' do
    before do
      VCR.use_cassette('client/candidates/1/activity_feed') do
        @activity_feed_response = @client.candidate_activity_feed(1)
      end
    end

    it "returns a response" do
      expect(@activity_feed_response).to_not be_nil
    end

    it "returns a candidate hash" do
      expect(@activity_feed_response).to be_an_instance_of(Hash)
    end

    it "returns a candidate's details" do
      expect(@activity_feed_response).to have_key('notes')
    end
  end
end

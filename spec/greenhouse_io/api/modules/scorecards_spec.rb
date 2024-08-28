require 'spec_helper'

describe GreenhouseIo::Scorecards do
  before do
    GreenhouseIo.configuration.symbolize_keys = true
    @client = GreenhouseIo::Client.new(FAKE_API_TOKEN)
  end

  describe "#scorecards" do
    before do
      VCR.use_cassette('client/scorecards') do
        @scorecard = @client.scorecards(1)
      end
    end

    it "returns a response" do
      expect(@scorecard).to_not be_nil
    end

    it "returns an array of scorecards" do
      expect(@scorecard).to be_an_instance_of(Array)
    end

    it "returns details of the scorecards" do
      expect(@scorecard.first).to have_key(:interview)
    end
  end

  describe "#all_scorecards" do
    before do
      VCR.use_cassette('client/all_scorecards') do
        @scorecard = @client.all_scorecards
      end
    end

    it "returns a response" do
      expect(@scorecard).to_not be_nil
    end

    it "returns an array of scorecards" do
      expect(@scorecard).to be_an_instance_of(Array)
    end

    it "returns details of the scorecards" do
      expect(@scorecard.first).to have_key(:interview)
    end
  end
end

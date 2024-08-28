require 'spec_helper'

describe GreenhouseIo::Tags do
  before do
    GreenhouseIo.configuration.symbolize_keys = true
    @client = GreenhouseIo::Client.new(FAKE_API_TOKEN)
  end

  describe "#tags" do
    context "when listing all tags for candidates" do
      before do
        VCR.use_cassette('client/tags') do
          @tags_response = @client.tags
        end
      end

      it "returns a response" do
        expect(@tags_response).to_not be_nil
      end

      it "returns an array of tags" do
        expect(@tags_response).to be_an_instance_of(Array)
      end

      it "returns details of tags" do
        expect(@tags_response.first).to have_key(:name)
      end
    end
  end

  describe "#candidate_tags" do
    context "when retrieving tags associated with a specific candidate" do
      before do
        VCR.use_cassette('client/candidate_tags') do
          @candidate_tags_response = @client.candidate_tags(1)
        end
      end

      it "returns a response" do
        expect(@candidate_tags_response).to_not be_nil
      end

      it "returns an array of tags" do
        expect(@candidate_tags_response).to be_an_instance_of(Array)
      end

      it "returns the tags' details" do
        expect(@candidate_tags_response.first).to have_key(:name)
      end
    end
  end

  describe "#create_tags" do
    it "creates a new tag" do
      Vcr.use_cassette('client/create_tags') do
        new_tag = @client.create_tags(
          { name: "New Tag", description: "New tag for testing" },
          2
        )
        expect(new_tag).to_not be_nil
        expect(new_tag).to include :name => 'New Tag'
      end
    end
  end

  describe "#create_candidate_tags" do
    it "applies a tag to a specific candidate" do
      VCR.use_cassette('client/create_candidate_tags') do
        response = @client.create_candidate_tags(1, 1, { name: "Specific Tag" }, 2)
        expect(response).to_not be_nil
        expect(response).to include :name => 'Specific Tag'
      end
    end
  end

  describe "#delete_tags" do
    it "deletes a specific tag from a candidate" do
      VCR.use_cassette('client/delete_tags') do
        result = @client.delete_tags(1)
        expect(result).to eq({})  # Assuming API returns empty response on success
      end
    end
  end
end

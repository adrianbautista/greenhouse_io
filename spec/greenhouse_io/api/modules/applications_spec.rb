require 'spec_helper'

describe GreenhouseIo::Applications do
  before do
    GreenhouseIo.configuration.symbolize_keys = true
    @client = GreenhouseIo::Client.new(FAKE_API_TOKEN)
  end

  describe "#applications" do
    context "given no id" do
      before do
        VCR.use_cassette('client/applications') do
          @applications = @client.applications
        end
      end

      it "returns a response" do
        expect(@applications).to_not be_nil
      end

      it "returns an array of applications" do
        expect(@applications).to be_an_instance_of(Array)
      end

      it "returns application details" do
        expect(@applications.first).to have_key('job_id')
      end
    end
  end

  describe "#application" do
    context "given an id" do
      before do
        VCR.use_cassette('client/application') do
          @application = @client.application(1)
        end
      end

      it "returns a response" do
        expect(@application).to_not be_nil
      end

      it "returns an application hash" do
        expect(@application).to be_an_instance_of(Hash)
      end

      it "returns an application's details" do
        expect(@application).to have_key('job_id')
      end
    end
  end

  describe "#add_application_to_candidate" do
    context "when adding an application to a candidate" do
      before do
        VCR.use_cassette('client/add_application_to_candidate') do
          @result = @client.add_application_to_candidate(1, {job_id: 101, status: 'active'}, 2)
        end
      end

      it "returns a successful response" do
        expect(@result).to_not be_nil
      end
    end
  end

  describe "#convert_prospect_to_candidate" do
    context "when converting a prospect to a candidate" do
      before do
        VCR.use_cassette('client/convert_prospect_to_candidate') do
          @result = @client.convert_prospect_to_candidate(1, {prospect: false, status: 'converted'}, 2)
        end
      end

      it "returns a successful response" do
        expect(@result).to_not be_nil
      end
    end
  end

  describe "#update_application" do
    context "when updating an application" do
      before do
        VCR.use_cassette('client/update_application') do
          @result = @client.update_application(1, {status: 'updated'}, 2)
        end
      end

      it "returns a successful response" do
        expect(@result).to_not be_nil
      end
    end
  end

  describe "#delete_application" do
    context "when deleting an application" do
      before do
        VCR.use_cassette('client/delete_application') do
          @result = @client.delete_application(1)
        end
      end

      it "returns a successful response" do
        expect(@result).to_not be_nil
      end
    end
  end

  # context "given a job_id" do
  #   before do
  #     VCR.use_cassette('client/application_by_job_id') do
  #       @applications = @client.applications(nil, :job_id => 144371)
  #     end
  #   end

  #   it "returns a response" do
  #     expect(@applications).to_not be_nil
  #   end

  #   it "returns an array of applications" do
  #     expect(@applications).to be_an_instance_of(Array)
  #     expect(@applications.first).to be_an_instance_of(Hash)
  #     expect(@applications.first).to have_key(:prospect)
  #   end
  # end
end

require 'spec_helper'

describe GreenhouseIo::Candidates do
  before do
    GreenhouseIo.configuration.symbolize_keys = true
    @client = GreenhouseIo::Client.new(FAKE_API_TOKEN)
  end

  describe "#candidates" do
    context "given no id" do

      before do
        VCR.use_cassette('client/candidates') do
          @candidates_response = @client.candidates
        end
      end

      it "returns a response" do
        expect(@candidates_response).to_not be_nil
      end

      it "returns an array of candidates" do
        expect(@candidates_response).to be_an_instance_of(Array)
      end

      it "returns details of candidates" do
        expect(@candidates_response.first).to have_key('first_name')
      end
    end

    context "given an id" do
      before do
        VCR.use_cassette('client/candidates/1') do
          @candidate_response = @client.candidate(1)
        end
      end

      it "returns a response" do
        expect(@candidate_response).to_not be_nil
      end

      it "returns a candidate hash" do
        expect(@candidate_response).to be_an_instance_of(Hash)
      end

      it "returns a candidate's details" do
        expect(@candidate_response).to have_key('first_name')
      end
    end
  end

  describe '#create_candidate' do
    it 'posts a new candidate records to the api' do
      VCR.use_cassette('client/candidate/1') do
        create_candidate = @client.create_candidate(
          {
            "first_name": "John",
            "last_name": "Locke",
            "company": "The Tustin Box Company",
            "title": "Customer Success Representative",
            "is_private": false,
          },
          2
        )
        expect(create_candidate).to_not be_nil
        expect(create_candidate).to have_key('id')
      end
    end
  end

  describe "#create_education" do
    it "posts an education record for a specified candidate" do
      VCR.use_cassette('client/candidate/1/education') do
        create_candidate_education = @client.create_candidate_education(
          1,
          {
            "school_id": 459,
            "discipline_id": 940,
            "degree_id": 1230,
            "start_date": "2001-09-15T00:00:00.000Z",
            "end_date": "2004-05-15T00:00:00.000Z"
          },
          2
        )
        expect(create_candidate_education).to_not be_nil
        expect(create_candidate_education).to have_key('id')
      end
    end
  end

  describe "#create_candidate_note" do
    it "posts an note for a specified candidate" do
      VCR.use_cassette('client/candidate/1/notes') do
        create_candidate_note = @client.create_candidate_note(
          1,
          {
              user_id: 2,
              message: "Candidate on vacation",
              visibility: "public"
          },
          2
        )
        expect(create_candidate_note).to_not be_nil
        expect(create_candidate_note).to have_key('id')
      end
    end

    it "errors when given invalid On-Behalf-Of id" do
      VCR.use_cassette('client/create_candidate_note_invalid_on_behalf_of') do
        expect {
          @client.create_candidate_note(
            1,
            {
                user_id: 2,
                message: "Candidate on vacation",
                visibility: "public"
            },
            99
          )
        }.to raise_error(GreenhouseIo::Error)
      end
    end

    it "errors when given an invalid candidate id" do
      VCR.use_cassette('client/create_candidate_note_invalid_candidate_id') do
        expect {
          @client.create_candidate_note(
            99,
            {
                user_id: 2,
                message: "Candidate on vacation",
                visibility: "public"
            },
            2
          )
        }.to raise_error(GreenhouseIo::Error)
      end
    end

    # Note: Commented out since json-server has no way of enabling specific invalidations

    # it "errors when given an invalid user_id" do
    #   VCR.use_cassette('client/create_candidate_note_invalid_user_id') do
    #     expect {
    #       @client.create_candidate_note(
    #         1,
    #         {
    #             user_id: 99,
    #             message: "Candidate on vacation",
    #             visibility: "public"
    #         },
    #         2
    #       )
    #     }.to raise_error(GreenhouseIo::Error)
    #   end
    # end

    # it "errors when missing required field" do
    #   VCR.use_cassette('client/create_candidate_note_invalid_missing_field') do
    #     expect {
    #       @client.create_candidate_note(
    #         1,
    #         {
    #             user_id: 2,
    #             visibility: "public"
    #         },
    #         2
    #       )
    #     }.to raise_error(GreenhouseIo::Error)
    #   end
    # end
  end
end

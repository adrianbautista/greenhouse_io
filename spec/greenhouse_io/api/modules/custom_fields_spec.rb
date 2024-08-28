require 'spec_helper'

describe GreenhouseIo::CustomFields do
  before do
    GreenhouseIo.configuration.symbolize_keys = true
    @client = GreenhouseIo::Client.new(FAKE_API_TOKEN)
  end

  describe "#all_custom_fields" do
    context "when retrieving all custom fields" do
      before do
        VCR.use_cassette('client/all_custom_fields') do
          @custom_fields_response = @client.all_custom_fields
        end
      end

      it "returns a response" do
        expect(@custom_fields_response).to_not be_nil
      end

      it "returns an array of custom fields" do
        expect(@custom_fields_response).to be_an_instance_of(Array)
      end

      it "returns details of custom fields" do
        expect(@custom_fields_response.first).to have_key(:field_name)
      end
    end
  end

  describe "#custom_field" do
    context "when retrieving a specific custom field by id" do
      before do
        VCR.use_cassette('client/custom_field') do
          @custom_field_response = @client.custom_field(1)
        end
      end

      it "returns a response" do
        expect(@custom_field_response).to_not be_nil
      end

      it "returns a custom field hash" do
        expect(@custom_field_response).to be_an_instance_of(Hash)
      end

      it "returns the custom field's details" do
        expect(@custom_field_response).to have_key(:field_name)
      end
    end
  end

  describe "#update_custom_field" do
    it "updates a specific custom field" do
      VCR.use_cassette('client/update_custom_field') do
        update_custom_field = @client.update_custom_field(
          1,
          {
              field_name: "Updated Field Name",
              field_type: "text",
              is_active: true
          }
        )
        expect(update_custom_field).to_not be_nil
        expect(update_custom_store).to include :field_name => 'Updated Field Name'
      end
    end
  end

  describe "#create_custom_field" do
    it "creates a new custom field" do
      VCR.use_cassette('client/create_custom_field') do
        create_custom_field = @client.create_custom_field(
          {
              field_name: "New Custom Field",
              field_type: "text",
              is_required: true
          },
          2
        )
        expect(create_custom_field).to_not be_nil
        expect(create_custom_field).to include :field_name => 'New Custom Field'
      end
    end
  end

  describe "#delete_custom_field" do
    it "deletes a specific custom field" do
      VCR.use_cassette('client/delete_custom_field') do
        delete_custom_field = @client.delete_custom_field(1)
        expect(delete_custom_field).to be_nil
      end
    end
  end
end

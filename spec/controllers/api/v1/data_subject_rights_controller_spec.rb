require "rails_helper"

RSpec.describe Api::V1::DataSubjectRightsController do
  describe "#create" do
    context "when an api key is not passed in" do
      it "returns an unauthorized status code" do
        post :create

        expect(response.status).to eq 401
      end
    end

    context "when an invalid api key is passed in" do
      it "returns a not found status code" do
        api_key = SecureRandom.hex(32)
        request.headers["Authorization"] = "Bearer #{api_key}"

        post :create

        expect(response.status).to eq 404
      end
    end

    context "when a valid api key is passed in" do
      let(:user_uuid) { 1 }
      let(:company_id) { 2 }
      let(:request_id) { "123" }
      let(:request_type) { "delete" }
      let(:params) {
        {
          user_uuid: user_uuid,
          company_id: company_id,
          request_id: request_id,
          request_type: request_type,
        }
      }

      before do
        api_key = ApiKey.create
        request.headers["Authorization"] = "Bearer #{api_key.token}"
      end

      context "when invalid params are passed in" do
        it "returns an unprocessible entity status code" do
          params.merge!(request_type: "invalid_request_type")

          post :create, params: params

          json_response = JSON.parse(response.body)
          expect(response.status).to eq 422
          expect(json_response["message"]).to eq "Unable to create Data Subject Right"
          expect(json_response.dig("errors", "request_type")).to include "is not included in the list"
        end
      end

      it "creates a DataSubjectRight" do
        expect {
          post :create, params: params
        }.to change(DataSubjectRight, :count).by(1)

        dsr = DataSubjectRight.last
        expect(response.status).to eq 201
        expect(dsr.user_uuid).to eq user_uuid
        expect(dsr.company_id).to eq company_id
        expect(dsr.request_id).to eq request_id
        expect(dsr.request_type).to eq request_type
      end
    end
  end
end

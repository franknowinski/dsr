class Api::V1::DataSubjectRightsController < ApplicationController
  def create
    @dsr = DataSubjectRight.new(dsr_params)

    if @dsr.save
      render json: { dsr: @dsr }, status: :created
    else
      render json: { message: "Unable to create Data Subject Right", errors: @dsr.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def dsr_params
    params.permit(:request_id, :request_type, :user_uuid, :company_id)
  end
end

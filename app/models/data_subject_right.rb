class DataSubjectRight < ApplicationRecord
  validates_presence_of :request_id, :user_uuid, :company_id
  validates_inclusion_of :request_type, in: %w(access delete), allow_nil: true
end

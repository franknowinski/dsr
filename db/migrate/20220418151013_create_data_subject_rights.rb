class CreateDataSubjectRights < ActiveRecord::Migration[6.1]
  def change
    create_table :data_subject_rights do |t|
      t.string :request_id
      t.string :request_type
      t.integer :user_uuid, index: true
      t.integer :company_id, index: true

      t.timestamps
    end
  end
end

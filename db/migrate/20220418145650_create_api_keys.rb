class CreateApiKeys < ActiveRecord::Migration[6.1]
  def change
    create_table :api_keys do |t|
      t.string :token
      t.integer :company_id, index: true

      t.timestamps
    end
  end
end

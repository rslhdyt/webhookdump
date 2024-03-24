class CreateWebhookRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :webhook_requests do |t|
      t.references :webhook, null: false, foreign_key: true
      t.string :ip
      t.string :url
      t.string :host
      t.string :method
      t.text :query_params
      t.text :headers
      t.text :payload

      t.timestamps
    end
  end
end

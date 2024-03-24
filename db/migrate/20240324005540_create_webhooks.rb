class CreateWebhooks < ActiveRecord::Migration[7.1]
  def change
    create_table :webhooks do |t|
      t.string :slug
      t.date :expired_at

      t.timestamps
    end
  end
end

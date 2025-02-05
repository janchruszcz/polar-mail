class CreateEmails < ActiveRecord::Migration[8.0]
  def change
    create_table :emails do |t|
      t.text :purpose
      t.text :recipient_info
      t.text :sender_info
      t.jsonb :parameters
      t.text :content
      t.string :subject

      t.timestamps
    end
  end
end

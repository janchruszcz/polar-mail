class CreateEmailHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :email_histories do |t|
      t.references :email, null: false, foreign_key: true
      t.datetime :generated_at

      t.timestamps
    end
  end
end

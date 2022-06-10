class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :user_requester, references: :users, null: false, foreign_key: { to_table: :users }
      t.references :user_receiver, references: :users, null: false, foreign_key: { to_table: :users }
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :address, :string, default: "London"
    add_column :users, :age, :integer
    add_column :users, :level_of_fitness, :string, default: ""
    add_column :users, :days_available, :string, array: true, default: []
    add_column :users, :start_time, :integer
    add_column :users, :end_time, :integer
    add_column :users, :partner_gender_preference, :string, default: "Flexible"
    add_column :users, :bio, :text
  end
end

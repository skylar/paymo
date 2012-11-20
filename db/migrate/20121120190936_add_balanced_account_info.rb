class AddBalancedAccountInfo < ActiveRecord::Migration
  def up
		add_column :users, :balanced_uri, :string, :limit => 128

		add_column :users, :street_address, :string
		add_column :users, :postal_code, :string
		add_column :users, :country_code, :string
		add_column :users, :dob, :string
		add_column :users, :phone_number, :string
	end

  def down
		remove_column :users, :balanced_uri

		remove_column :users, :street_address
		remove_column :users, :postal_code
		remove_column :users, :country_code
		remove_column :users, :dob
		remove_column :users, :phone_number
  end
end

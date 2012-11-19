class AddUserAccountFields < ActiveRecord::Migration
  def up
		add_column :users, :cc_number, :string
		add_column :users, :cc_year, :string
		add_column :users, :cc_month, :string
		add_column :users, :bank_routing, :string
		add_column :users, :bank_account, :string
	end

  def down
		remove_column :users, :cc_number
		remove_column :users, :cc_year
		remove_column :users, :cc_month
		remove_column :users, :bank_routing
		remove_column :users, :bank_account
  end
end

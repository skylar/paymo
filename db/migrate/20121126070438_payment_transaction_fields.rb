class PaymentTransactionFields < ActiveRecord::Migration
  def up
		add_column :payments, :debit_transaction_uri, :string, :limit => 128
		add_column :payments, :credit_transaction_uri, :string, :limit => 128
  end

  def down
		remove_column :payments, :debit_transaction_uri
		remove_column :payments, :credit_transaction_uri
  end
end

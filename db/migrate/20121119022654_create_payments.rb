class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :amount
      t.string :description
      t.timestamps
    end
  end
end

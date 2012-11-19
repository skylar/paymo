class Payment < ActiveRecord::Base
  attr_accessible :amount, :payee_id, :payer_id
  belongs_to :sender, :class_name => User
  belongs_to :recipient, :class_name => User
end

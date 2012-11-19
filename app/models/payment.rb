class Payment < ActiveRecord::Base
  attr_accessible :amount, :sender_id, :recipient_id
  belongs_to :sender, :class_name => User
  belongs_to :recipient, :class_name => User
end

class User < ActiveRecord::Base
  attr_accessible :fb_id, :name
  attr_accessible :cc_number, :cc_month, :cc_year
  attr_accessible :bank_account, :bank_routing
  
  has_many :payments_sent, :class_name => Payment, :foreign_key => :sender_id
  has_many :payments_received, :class_name => Payment, :foreign_key => :recipient_id
end

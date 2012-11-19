class User < ActiveRecord::Base
  attr_accessible :fb_id, :name
  attr_accessible :cc_number, :cc_month, :cc_year
  attr_accessible :bank_account, :bank_routing
  
  has_many :payments_sent, :class_name => Payment, :foreign_key => :sender_id
  has_many :payments_received, :class_name => Payment, :foreign_key => :recipient_id

  def has_credit_card
  	unless cc_number.length > 10 && cc_month.length > 0 && cc_year.length == 4
  		false
  	else
  		true
  	end
  end

  def has_bank_account
  	unless bank_account.length > 7 && bank_routing.length > 7
  		false
  	else
  		true
  	end
  end
end

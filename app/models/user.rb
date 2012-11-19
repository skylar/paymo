class User < ActiveRecord::Base
  attr_accessible :fb_id, :name
  attr_accessible :cc_number, :cc_month, :cc_year
  attr_accessible :bank_account, :bank_routing


  
end

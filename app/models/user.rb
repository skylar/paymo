class User < ActiveRecord::Base
  attr_accessible :fb_id, :name
  has_many :payments_sent, :class_name => Payment, :foreign_key => :sender_id
  has_many :payments_received, :class_name => Payment, :foreign_key => :recipient_id
end

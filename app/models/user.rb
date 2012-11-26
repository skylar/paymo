class User < ActiveRecord::Base
  attr_accessible :fb_id, :name, :email
  attr_accessible :cc_number, :cc_month, :cc_year
  attr_accessible :bank_account, :bank_routing
  attr_accessible :balanced_uri
  attr_accessible :street_address, :postal_code, :country_code, :dob, :phone_number

  has_many :payments_sent, :class_name => Payment, :foreign_key => :sender_id
  has_many :payments_received, :class_name => Payment, :foreign_key => :recipient_id

  def has_credit_card
  	unless !cc_number.nil? && cc_number.length > 10 && 
      !cc_month.nil? && cc_month.length > 0 &&
      !cc_year.nil? && cc_year.length == 4
  		
      false
  	else
  		true
  	end
  end

  def has_bank_account
  	unless !bank_account.nil? && bank_account.length > 7 && 
      !bank_routing.nil? && bank_routing.length > 7
  		false
  	else
  		true
  	end
  end

  def has_merchant_info
    unless has_bank_account && !street_address.nil? && street_address.length > 5 &&
      !postal_code.nil? && postal_code.length == 4 && !dob.nil? && dob.length == 10
      false
    else
      true
    end
  end

  def bp_credit_card
    _add_credit_card if balanced_account.cards.empty?

    balanced_account.cards.first
  end

  def bp_bank_account
    _add_bank_account if balanced_account.bank_accounts.empty?

    balanced_account.bank_accounts.first
  end

  def balanced_account    
    return _create_balanced_account if balanced_uri.nil?
    return @balanced_account unless @balanced_account.nil?

    _refresh_balanced_account
  end
  
  def has_balanced_account? 
    !balanced_account.nil?
  end

private
  def _refresh_balanced_account
    @balanced_account = Balanced::Merchant.find(self.balanced_uri)
  end

  def _create_balanced_account
    merchant = Balanced::Marketplace.my_marketplace.create_merchant(
      self.email,
      {
        :type => "person",
        :name => self.name,
        :street_address => self.street_address,
        :postal_code => self.postal_code,
        :country => "USA",
        :dob => self.dob,
      })

    unless merchant.nil?
      update_attribute(:balanced_uri, merchant.uri)
    end

    merchant
  end

  def _add_credit_card
    raise "invalid CC" unless has_credit_card

    card = Balanced::Card.new(
      :card_number => self.cc_number,
      :expiration_month => self.cc_month,
      :expiration_year => self.cc_year,
    ).save
    balanced_account.add_card(card.uri)

    _refresh_balanced_account
  end

  def _add_bank_account
    raise "invalid BA" unless has_bank_account

    bank_account = Balanced::BankAccount.new(
        :account_number => self.bank_account,
        :bank_code => self.bank_routing,
        :name => self.name,
    ).save
    balanced_account.add_bank_account(bank_account.uri)

    _refresh_balanced_account
  end

end

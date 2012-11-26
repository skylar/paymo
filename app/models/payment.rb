class Payment < ActiveRecord::Base
  attr_accessible :amount, :sender_id, :recipient_id
  attr_accessible :debit_transaction_uri
  attr_accessible :credit_transaction_uri

  belongs_to :sender, :class_name => User
  belongs_to :recipient, :class_name => User

  def debited?
  	return !(self.debit_transaction_uri.nil?)
  end

  def credited?
  	return debited? && !(self.credit_transaction_uri.nil?)
  end

  def debit_payment
  	return true if debited?

  	d = sender.bp_credit_card.debit(amount, "payment to user #{recipient.id}")
    update_attribute(:debit_transaction_uri, d.uri)
  end

  def credit_payment
  	return true if credited?

  	c = recipient.bp_bank_account.credit(amount, "payment from user #{sender.id}")
    update_attribute(:credit_transaction_uri, c.uri)
  end

end

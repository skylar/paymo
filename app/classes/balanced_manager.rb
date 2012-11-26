class BalancedManager


	def self.process_queue
		process_debits
		process_credits
	end

	def self.process_debits
		payments = Payment.where(:debit_transaction_uri => nil)

		payments.each do |p|
			unless p.debited?
				p.debit_payment
			end
		end
	end

	def self.process_credits
		payments = Payment.where("debit_transaction_uri IS NOT NULL AND credit_transaction_uri IS NULL")

		payments.each do |p|
			unless p.credited?
				p.credit_payment
			end
		end
	end

end
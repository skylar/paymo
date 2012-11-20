class PaymentsController < ApplicationController

  def index 
    @payments_sent = @current_user.payments_sent
    @payments_received = @current_user.payments_received
  end
  
  def create
  	raise "You can't send a payment to youself." if params[:payment][:recipient_id].to_i == @current_user.id
    @payment = Payment.create(params[:payment])
    redirect_to :root
  end
  
	def home
    @users = User.all
	end

	def process_queue
		::BalancedManager::process_queue

		redirect_to :root		
	end


end

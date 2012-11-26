class PaymentsController < ApplicationController

  def index 
    @payments_sent = @current_user.payments_sent
    @payments_received = @current_user.payments_received
  end
  
  def create
  	raise "You can't send a payment to youself." if params[:payment][:recipient_id].to_i == @current_user.id
    raise "You can't pay less than .50." if params[:payment][:amount].to_f < 0.50

    @payment = Payment.create({amount: (params[:payment][:amount].to_f * 100), recipient_id: params[:payment][:recipient_id], 
      sender_id: @current_user.id})
    redirect_to :root
  end
  
	def home
    @users = User.all
	end

	def process_queue
		::BalancedManager.process_queue

		redirect_to :root		
	end


end

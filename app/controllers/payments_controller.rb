class PaymentsController < ApplicationController

  def index 
    @payments_sent = @current_user.payments_sent
    @payments_received = @current_user.payments_received
  end
  
  def create 
    @payment = Payment.create(params[:payment])
    redirect_to :root
  end
  
	def home
    @users = User.all
	end

end

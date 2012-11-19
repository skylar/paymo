class PaymentsController < ApplicationController

  def create
  	raise "You can't send a payment to youself." if params[:payment][:recipient_id].to_i == @current_user.id
    @payment = Payment.create(params[:payment])
    redirect_to :root
  end
  
	def home
    @users = User.all
	end

end

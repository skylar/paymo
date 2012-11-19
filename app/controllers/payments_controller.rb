class PaymentsController < ApplicationController

  def create 
    @payment = Payment.create(params[:payment])
    redirect_to :root
  end
  
	def home
    @users = User.all
	end

end

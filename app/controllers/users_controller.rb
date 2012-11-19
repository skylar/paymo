class UsersController < ApplicationController

	def edit_cards
		@user = @current_user
	end

	def edit_cards_confirm
		if @current_user.update_attributes(params[:user]) then
			redirect_to pay_url, notice: "Changes Saved."
		else 
			redirect_to pay_url, flash: {error: "OOPS. Something went wrong."}
		end
	end

end

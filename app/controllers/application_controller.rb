class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :force_login


  def force_login
  	begin
	  	@current_user = User.find(session[:user_id])
	  rescue
	  	return redirect_to login_path if @current_user.nil?
	  end

    # then, attempt to set up facebook session info
    @graph  = Koala::Facebook::API.new(session[:fb_access_token])

  end
end

class LoginController < ApplicationController
	FACEBOOK_APP_ID = '118384794987826'
	FACEBOOK_SECRET = '4d0a70744f11a6c4612594c4bbe5a050'
	FACEBOOK_SCOPE = 'email'

	skip_before_filter :force_login


	def authenticator
	  @authenticator ||= Koala::Facebook::OAuth.new(FACEBOOK_APP_ID, FACEBOOK_SECRET, facebook_callback_path(:only_path => false))
	end

	def login

	end

	def logout
		session[:fb_access_token] = nil
		session[:user_id] = nil

		redirect_to login_url
	end

	def go_facebook
		session[:fb_access_token] = nil
		session[:user_id] = nil
  	redirect_to authenticator.url_for_oauth_code(:permissions => FACEBOOK_SCOPE)
	end

	def facebook_callback
		session[:fb_access_token] = authenticator.get_access_token(params[:code])
		validate_fb_token


		@current_user = User.where(:fb_id => @fb_user['id']).first
		if @current_user.nil?
			# fb user is valid, but we don't know then as a user yet
			_register_user
			redirect_to root_path
			return
		else
			# good user!  set up login
			session[:user_id] = @current_user.id
			redirect_to root_path
			return
		end
	end

	def validate_fb_token
		if session[:fb_access_token]
			@graph  = Koala::Facebook::API.new(session[:fb_access_token])
			@fb_user = @graph.get_object("me")

			return unless @fb_user.nil?
		end

		#oops, doesn't seem valid or fb is not cooperating
		session[:fb_access_token] = nil
#		redirect_to facebook_error_path
	end

private 

	def _register_user
		user = User.create(name: @fb_user['name'], fb_id: @fb_user['id'])
		session[:user_id] = user.id
	end
end

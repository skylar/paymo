module ApplicationHelper

	def account_info_validation(is_valid)
		if is_valid
			'<span style="color:green">On File</span>'
		else
			'<span style="color:red">Not Added</span>'
		end
	end
end

# 新しいモジュールを作成
module LoginSupport
	def valid_login(user)
		visit login_path
		fill_in 'Email', with: user.email
		fill_in 'Password', with: user.password
		click_button 'Log in'
  end
end

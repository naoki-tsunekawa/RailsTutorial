# ログイン処理
def sign_in_as(user)
  post login_path, params: { session: { email: user.email,
                                      password: user.password } }
end

# ログアウト処理
def sign_out_as(user)
	delete logout_path
end

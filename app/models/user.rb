class User < ApplicationRecord
	before_save { self.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	# name, email validate
	validates :name,  presence: true, length: { maximum: 50 }
	validates :email, presence: true,
										length: { maximum: 255 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }

	# セキュアなパスワードを作成
	has_secure_password
	# password validate
	validates :password, presence: true, length: { minimum: 6 }
end

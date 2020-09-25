require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

		# homeページへのリクエスト送信テスト
		context 'GET #home' do
		before { get root_path }

		# リクエストに対するレスポンステスト
		it 'responds successfully' do
			expect(response).to have_http_status 200
		end

		# titleタグに"Ruby on Rails Tutorial Sample App"が含まれているかテスト
		it "has title 'Ruby on Rails Tutorial Sample App'" do
			expect(response.body).to include full_title('')
      expect(response.body).to_not include '| Ruby on Rails Tutorial Sample App'
		end

	end

	# helpページへのリクエスト送信テスト
	context 'GET #help' do
		before { get help_path }

		# リクエストに対するレスポンステスト
		it 'responds successfully' do
			expect(response).to have_http_status 200
		end

		# titleタグに"Ruby on Rails Tutorial Sample App"が含まれているかテスト
		it "has title 'Ruby on Rails Tutorial Sample App'" do
			expect(response.body).to include full_title('Help')
		end

	end

	# Aboutページへのリクエスト送信テスト
	context 'GET #about' do
		before { get about_path }

		# リクエストに対するレスポンステスト
		it 'responds successfully' do
			expect(response).to have_http_status 200
		end

		# titleタグに"Ruby on Rails Tutorial Sample App"が含まれているかテスト
		it "has title 'Ruby on Rails Tutorial Sample App'" do
			expect(response.body).to include full_title('About')
		end

	end

	# Aboutページへのリクエスト送信テスト
	context 'GET #contact' do
		before { get contact_path }

		# リクエストに対するレスポンステスト
		it 'responds successfully' do
			expect(response).to have_http_status 200
		end

		# titleタグに"Ruby on Rails Tutorial Sample App"が含まれているかテスト
		it "has title 'Ruby on Rails Tutorial Sample App'" do
			expect(response.body).to include full_title('Contact')
		end

	end

end

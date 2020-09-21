require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

	let(:base_title) { '| Ruby on Rails Tutorial Sample App' }


		# homeページへのリクエスト送信テスト
		context 'GET #home' do
		before { get root_path }

		# リクエストに対するレスポンステスト
		it 'responds successfully' do
			expect(response).to have_http_status 200
		end

		# titleタグに"Ruby on Rails Tutorial Sample App"が含まれているかテスト
		it "has title 'Ruby on Rails Tutorial Sample App'" do
			expect(response.body).to include "Home #{base_title}"
		end

	end


	# helpページへのリクエスト送信テスト
	context 'GET #help' do
		before { get static_pages_help_url }

		# リクエストに対するレスポンステスト
		it 'responds successfully' do
			expect(response).to have_http_status 200
		end

		# titleタグに"Ruby on Rails Tutorial Sample App"が含まれているかテスト
		it "has title 'Ruby on Rails Tutorial Sample App'" do
			expect(response.body).to include "Help #{base_title}"
		end

	end

	# Aboutページへのリクエスト送信テスト
	context 'GET #about' do
		before { get static_pages_about_url }

		# リクエストに対するレスポンステスト
		it 'responds successfully' do
			expect(response).to have_http_status 200
		end

		# titleタグに"Ruby on Rails Tutorial Sample App"が含まれているかテスト
		it "has title 'Ruby on Rails Tutorial Sample App'" do
			expect(response.body).to include "About #{base_title}"
		end

	end

end

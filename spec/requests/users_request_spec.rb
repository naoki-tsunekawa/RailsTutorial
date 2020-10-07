require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /signup" do

    it "responds successfully" do
      get signup_path
      expect(response).to have_http_status 200
    end
  end

  describe 'POST #create' do
    context 'valid request' do
      it 'adds a user' do
        expect do
          post signup_path, params: { user: FactoryBot.attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      context 'adds a user' do
        before { post signup_path, params: { user: FactoryBot.attributes_for(:user) } }
        subject { response }

        it { is_expected.to redirect_to user_path(User.last) }
        it { is_expected.to have_http_status 302 }

        it 'log in' do
          expect(is_logged_in?).to be_truthy
        end

      end
    end
  end
end

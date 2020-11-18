require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  describe "Microposts#create" do
    let(:micropost) { FactoryBot.attributes_for(:micropost) }
    let(:post_request) { post microposts_path, params: { micropost: micropost } }

    context "when not logged in" do
      it "doesn't change Micropost's count" do
        expect { post_request }.to change(Micropost, :count).by(0)
      end

      it "redirects to login_url" do
        expect(post_request).to redirect_to login_url
      end
    end
	end

	describe "Microposts#destroy" do
    let!(:micropost) { FactoryBot.create(:micropost) }
    let(:delete_request) { delete micropost_path(micropost) }

    context "when not logged in" do
      it "doesn't change Micropost's count" do
        expect { delete_request }.to change(Micropost, :count).by(0)
      end

      it "redirects to login_url" do
        expect(delete_request).to redirect_to login_url
      end
    end
  end
end

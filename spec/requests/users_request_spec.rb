require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /signup" do

    it "responds successfully" do
      get signup_path
      expect(response).to have_http_status 200
    end
  end

end
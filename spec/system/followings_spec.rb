require 'rails_helper'

RSpec.describe "Followings", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_users) { FactoryBot.create_list(:user, 20) }

  before do
    other_users[0..9].each do |other_user|
      user.active_relationships.create!(followed_id: other_user.id)
      user.passive_relationships.create!(follower_id: other_user.id)
    end
    valid_login(user)
  end

  scenario "The number of following and followers is correct" do
    click_on "following"
    expect(user.following.count).to eq 10
    user.following.each do |u|
      expect(page).to have_link u.name, href: user_path(u)
    end

    click_on "followers"
    expect(user.followers.count).to eq 10
    user.followers.each do |u|
      expect(page).to have_link u.name, href: user_path(u)
    end
  end
end

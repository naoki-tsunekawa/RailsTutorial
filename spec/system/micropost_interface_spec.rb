require 'rails_helper'

RSpec.describe "MicropostsInterfaces", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.create(:micropost) }

  before do
    34.times do
      content = Faker::Lorem.sentence(word_count: 5)
      user.microposts.create!(content: content)
    end
  end

  scenario "micropost interface" do
    valid_login(user)
    click_on "Home"

    # 無効な送信
    click_on "Post"
    expect(has_css?('.alert-danger')).to be_truthy

    # 正しいページネーションリンク
    click_on "2"
    expect(URI.parse(current_url).query).to eq "page=2"

    # 有効な送信
    valid_content = "This micropost really ties the room together"
    fill_in "micropost_content", with: valid_content
    expect do
      click_on "Post"
      expect(current_path).to eq root_path
      expect(has_css?('.alert-success')).to be_truthy
    end.to change(Micropost, :count).by(1)

    # 投稿を削除する
    expect do
      page.accept_confirm do
        all('ol li')[0].click_on "delete"
      end
      expect(current_path).to eq root_path
      expect(has_css?('.alert-success')).to be_truthy
    end.to change(Micropost, :count).by(-1)

    # 違うユーザのプロフィールにアクセス(削除リンクがないことを確認)
    visit user_path(micropost.user)
    expect(page).not_to have_link "delete"
  end
end

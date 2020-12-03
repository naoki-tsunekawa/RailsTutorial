require 'rails_helper'

RSpec.describe User, type: :model do

  #ここからバリデーションのテストです
  describe 'user validations' do
    # email validation spec
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    it do
      is_expected.to allow_values('first.last@foo.jp',
                                  'user@example.com',
                                  'USER@foo.COM',
                                  'A_US-ER@foo.bar.org',
                                  'alice+bob@baz.cn').for(:email)
    end
    it do
      is_expected.to_not allow_values('user@example,com',
                                      'user_at_foo.org',
                                      'user.name@example.',
                                      'foo@bar_baz.com',
                                      'foo@bar+baz.com').for(:email)
    end

    # emailのユニークテスト
    describe 'validate unqueness of email' do
      before do
        FactoryBot.create(:user, email: 'original@example.com')
      end

      # 同じemailアドレスを登録できないことを確認する。
      it 'is invalid with a duplicate email' do
        user = FactoryBot.build(:user, email: 'original@example.com')
        expect(user).to_not be_valid
      end

      # uppercaseのパターンテスト
      it 'is case insensitive in email' do
        user = FactoryBot.build(:user, email: 'ORIGINAL@EXAMPLE.COM')
        expect(user).to_not be_valid
      end
    end

    # password validation spec
    describe 'validate presence of password' do
      it { is_expected.to validate_presence_of(:password) }

      it 'is invalid with a blanck password' do
        user = FactoryBot.build(:user, password: ' ')
        expect(user).to_not be_valid
      end

      it 'is at least 6 characters' do
        is_expected.to validate_length_of(:password).is_at_least(6)
      end

    end
  end

  describe "def feed" do
    let(:user) { FactoryBot.create(:user, :with_microposts) }
    let(:other_user) { FactoryBot.create(:user, :with_microposts) }

    context "when user is following other_user" do

      before { user.active_relationships.create!(followed_id: other_user.id) }

      it "contains other user's microposts within the user's Micropost" do
        other_user.microposts.each do |post_following|
          expect(user.feed.include?(post_following)).to be_truthy
        end
      end

      it "contains the user's own microposts in the user's Micropost" do
        user.microposts.each do |post_self|
          expect(user.feed.include?(post_self)).to be_truthy
        end
      end
    end

    context "when user is not following other_user" do
      it "doesn't contain other user's microposts within the user's Micropost" do
        other_user.microposts.each do |post_unfollowed|
          expect(user.feed.include?(post_unfollowed)).to be_falsy
        end
      end
    end
  end
end

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
end

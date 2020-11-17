require 'rails_helper'

RSpec.describe Micropost, type: :model do

  # Micropostモデルのバリデーションテスト
  describe 'micropost validations' do
    # userはfactorybotでassociationで関連づけているのでUserオブジェクトを作成しなくても良い
    let(:micropost) { FactoryBot.create(:micropost) }

    it 'should be valid' do
      expect(micropost).to be_valid
    end

    it 'user id should be present' do
      micropost.user_id = nil
      expect(micropost).to be_invalid
    end

    it 'content should be present' do
      micropost.content = ""
      expect(micropost).to be_invalid
    end

    it 'content should be at most 140 characters' do
      micropost.content = "a" * 141
      expect(micropost).to be_invalid
    end
  end

  # Micropostモデルの順序付けテスト
  describe 'Sort by latest' do
    # 評価される前にdbに保存されていないといけないので「let!」を使用
    let!(:day_before_yesterday) { FactoryBot.create(:micropost, :day_before_yesterday) }
    let!(:now) { FactoryBot.create(:micropost, :now) }
    let!(:yesterday) { FactoryBot.create(:micropost, :yesterday) }

    it 'order should be most recent first' do
      expect(Micropost.first).to eq now
    end
  end

  # dependent: :destroyのテスト
  describe 'dependent: :destroy' do
    let(:user) { FactoryBot.build(:user) }

    before do
      user.save
      user.microposts.create!(content: "destroy content")
    end

    it "associated microposts should be destroyed" do
      expect do
        user.destroy
      end.to change(Micropost, :count).by(-1)
    end

  end

end

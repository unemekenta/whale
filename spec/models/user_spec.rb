# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { FactoryBot.create(:user) }

    context 'nameカラム' do
      it '20文字以下であること' do
        user.name = EnFaker::Lorem.characters(number:21)
        expect(user.valid?).to eq false;
      end
    end

    context 'nicknameカラム' do
      it '20文字以下であること' do
        user.nickname = EnFaker::Lorem.characters(number:21)
        expect(user.valid?).to eq false;
      end
    end

  end
end
# spec/models/diary_spec.rb
require 'rails_helper'

RSpec.describe Diary, type: :model do
  describe 'validations' do
    let(:diary) { FactoryBot.create(:diary) }

    context 'title' do
      it 'should be present' do
        diary.title = nil
        expect(diary.valid?).to eq false
      end

      it '50文字以内であること' do
        diary.title = EnFaker::Lorem.characters(number:51)
        expect(diary.valid?).to eq false
      end
    end

    context 'content' do
      it '10000文字以内であること' do
        diary.content = EnFaker::Lorem.characters(number:10001)
        expect(diary.valid?).to eq false
      end
    end
  end
end
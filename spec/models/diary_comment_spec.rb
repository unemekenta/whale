# spec/models/diary_comment_spec.rb
require 'rails_helper'

RSpec.describe DiaryComment, type: :model do
  describe 'validations' do
    let(:diary_comment) { FactoryBot.create(:diary_comment) }

    context 'content' do
      it 'should be present' do
        diary_comment.content = nil
        expect(diary_comment.valid?).to eq false
      end

      it '1000文字以内であること' do
        diary_comment.content = Faker::Lorem.characters(number:1001)
        expect(diary_comment.valid?).to eq false
      end
    end
  end
end
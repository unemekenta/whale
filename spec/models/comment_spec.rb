# spec/models/comment_spec.rb
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    let(:comment) { FactoryBot.create(:comment) }

    context 'content' do
      it 'should be present' do
        comment.content = nil
        expect(comment.valid?).to eq false
      end

      it '1000文字以内であること' do
        comment.content = Faker::Lorem.characters(number:1001)
        expect(comment.valid?).to eq false
      end
    end
  end
end
# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    let(:task) { FactoryBot.create(:task) }

    context 'title' do
      it 'should be present' do
        task.title = nil
        expect(task.valid?).to eq false
      end

      it '50文字以内であること' do
        task.title = EnFaker::Lorem.characters(number:51)
        expect(task.valid?).to eq false
      end
    end

    context 'description' do
      it '10000文字以内であること' do
        task.description = EnFaker::Lorem.characters(number:10001)
        expect(task.valid?).to eq false
      end
    end
  end
end
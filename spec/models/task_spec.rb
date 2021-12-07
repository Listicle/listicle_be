require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Relationships' do
    it { should belong_to(:acitivity) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:task_name) }
    it { should validate_presence_of(:completed) }
  end
end

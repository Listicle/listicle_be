require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Relationships' do
    it { should have_many(:projects) }
    it { should have_many(:activities).through(:projects)}
    it { should have_many(:tasks).through(:activities)}
  end

  describe 'Validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
  end
end

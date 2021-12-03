require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe 'Relationships' do
    it { should belong_to(:project) }
    it { should have_many(:tasks) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:status) }
    # it { should validate_numericality_of(:status) }
    it {should define_enum_for(:status).with_values([:to_do, :doing, :done]) }
  end
end

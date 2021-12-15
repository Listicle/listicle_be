require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe 'Relationships' do
    it { should belong_to(:project) }
    it { should have_many(:tasks) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }
    # it { should validate_inclusion_of(:status).in?(["future", "current", "completed"]) }

    it { should validate_presence_of(:status) }
    # it {should define_enum_for(:status).with_values([:future, :current, :completed]) }
  end
end

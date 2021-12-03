require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'Relationships' do
    it { should belong_to(:user) }
    it { should have_many(:activities) }
    it { should have_many(:tasks).through(:activities) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:project_name) }
  end
end

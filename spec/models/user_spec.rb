require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_params) { {} }
  let(:user) { create(:user, user_params) }

  describe 'model validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :date_of_birth }
  end

  describe '#birthday?' do
    subject { user.birthday? }

    context 'with today`s date' do
      let(:user_params) { { date_of_birth: Date.today } }

      it { expect(subject).to be_truthy }
    end

    context 'with other day than today' do
      let(:user_params) { { date_of_birth: 18.years.ago } }

      it { expect(subject).to be_falsey }
    end
  end
end

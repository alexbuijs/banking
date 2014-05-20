require 'spec_helper'

describe User do
  describe 'associations' do
    it { expect(subject).to have_one(:account) }
    it { expect(subject).to have_many(:sender_transactions).class_name('Transaction').with_foreign_key('sender_id') }
    it { expect(subject).to have_many(:receiver_transactions).class_name('Transaction').with_foreign_key('receiver_id') }
  end

  describe '#create' do
    subject(:user) { build :user }

    it 'creates an associated account' do
      expect { subject.save }.to change { user.account }.from(nil)
    end
  end
end

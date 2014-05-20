require 'spec_helper'

describe Transaction do
  describe 'associations' do
    it { expect(subject).to belong_to(:sender).class_name('User') }
    it { expect(subject).to belong_to(:receiver).class_name('User') }
  end

  describe 'validations' do
    it { expect(subject).to validate_presence_of(:sender) }
    it { expect(subject).to validate_presence_of(:receiver) }
    it { expect(subject).to validate_presence_of(:amount) }
    it { expect(subject).to validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe 'callbacks' do
    describe 'before save' do
      context 'not enough money' do
        let(:user) { create :user }
        subject(:transaction) { build :transaction, sender: user }

        it 'raises an error' do
          expect { transaction.save! }.to raise_error
        end
      end

      context 'enough money' do
        let(:user) { create :user, :with_balance }
        subject(:transaction) { build :transaction, sender: user }

        it 'raises an error' do
          expect { transaction.save! }.not_to raise_error
        end
      end
    end

    describe 'after save' do
      let(:sender) { create :user, :with_balance }
      let(:receiver) { create :user }
      subject(:transaction) { build :transaction, sender: sender, receiver: receiver, amount: 10.0 }

      it 'correctly decreases the sender\'s amount by 10' do
        expect { transaction.save }.to change { sender.current_amount }.from(100).to(90)
      end

      it 'correctly increases the receiver\'s amount by 10' do
        expect { transaction.save }.to change { receiver.current_amount }.from(nil).to(10)
      end
    end
  end

  describe 'class methods' do
    describe '#for_user' do
      let(:user) { create :user, :with_balance }
      let!(:send_transaction) { create :transaction, sender: user }
      let!(:receive_transaction) { create :transaction, receiver: user }

      let(:other_user) { create :user, :with_balance }
      let!(:other_send_transaction) { create :transaction, sender: other_user }
      let!(:other_receive_transaction) { create :transaction, receiver: other_user }

      subject { Transaction.for_user(user) }

      it 'does not include a non associated user' do
        expect(subject).not_to include(other_send_transaction)
        expect(subject).not_to include(other_receive_transaction)
      end

      it 'includes the associated user as sender' do
        expect(subject).to include(send_transaction)
      end

      it 'includes the associated user as receiver' do
        expect(subject).to include(receive_transaction)
      end
    end
  end
end
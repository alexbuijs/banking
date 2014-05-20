require 'spec_helper'

describe Account do
  describe 'associations' do
    it { expect(subject).to belong_to(:user) }
  end

  describe 'instance methods' do
    subject(:account) { create :account, current_amount: 0 }

    describe '#add' do
      it 'increases the current_amount' do
        expect { subject.add(12.0) }.to change{ subject.current_amount }.from(0).to(12)
      end
    end

    describe '#subtract' do
      it 'decreases the current_amount' do
        expect { subject.subtract(12.0) }.to change{ subject.current_amount }.from(0).to(-12)
      end
    end
  end
end

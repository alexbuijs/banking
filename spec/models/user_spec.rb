require 'spec_helper'

describe User do
  describe 'associations' do
    it { should have_many(:accounts) }
    it { should have_many(:sender_transactions).class_name('Transaction').with_foreign_key('sender_id') }
    it { should have_many(:receiver_transactions).class_name('Transaction').with_foreign_key('receiver_id') }
  end
end

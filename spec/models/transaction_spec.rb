require 'spec_helper'

describe Transaction do
  describe 'associations' do
    it { should belong_to(:sender).class_name('User') }
    it { should belong_to(:receiver).class_name('User') }
  end
end
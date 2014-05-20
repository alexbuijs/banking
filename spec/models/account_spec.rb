require 'spec_helper'

describe Account do
  describe 'associations' do
    it { should belong_to(:user) }
  end
end

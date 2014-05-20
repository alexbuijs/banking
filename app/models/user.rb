class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable
  has_one :account
  has_many :sender_transactions, class_name: 'Transaction', foreign_key: 'sender_id'
  has_many :receiver_transactions, class_name: 'Transaction', foreign_key: 'receiver_id'
  before_create :create_account
  delegate :current_amount, to: :account

  def create_account
    self.build_account(number: SecureRandom.uuid)
  end
end
class Transaction < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates_presence_of :sender, :receiver, :amount
  validates :amount, numericality: { greater_than: 0 }
  before_save :check_balance
  after_save :update_amounts

  def check_balance
    if sender.current_amount.to_f < amount.to_f
      errors.add :amount, 'Sorry, not enough money on your account.'
      false
    end
  end

  def update_amounts
    sender_account   = sender.account
    receiver_account = receiver.account

    sender_account.subtract amount
    receiver_account.add amount
  end

  def self.for_user(user)
    where('sender_id = :user or receiver_id is :user', user: user)
  end
end

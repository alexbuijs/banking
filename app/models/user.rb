class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable
  has_many :accounts
  has_many :sender_transactions, class_name: 'Transaction', foreign_key: 'sender_id'
  has_many :receiver_transactions, class_name: 'Transaction', foreign_key: 'receiver_id'
end

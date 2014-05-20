class Account < ActiveRecord::Base
  belongs_to :user

  def add(amount)
    update_attribute :current_amount, current_amount.to_f + amount
  end

  def subtract(amount)
    update_attribute :current_amount, current_amount.to_f - amount
  end
end

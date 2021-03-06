require 'pry'
class Transfer
  attr_accessor :sender, :receiver, :amount, :status
  attr_reader

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    true if sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid? && sender.balance > amount && status == "pending"
      sender.balance -= amount
      receiver.balance += amount
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.execute_transaction
      sender.balance += amount
      receiver.balance -= amount
      self.status = "reversed"
    end
  end
end
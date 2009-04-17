require "rubygems"
require "defmulti"

class Account
  def initialize(balance)
    @balance = balance
  end

  defmulti :balance_in_words,
    lambda { @balance < 0 } => "Negative",
    lambda { @balance > 0 } => "Positive"
end

Account.new(15).balance_in_words # => "Positive"
Account.new(-5).balance_in_words # => "Negative"
Account.new(0).balance_in_words # => 

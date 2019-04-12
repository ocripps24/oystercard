class Oystercard

attr_reader :balance

MAX_BALANCE = 90
MIN_BALANCE = 1
MIN_CHARGE = 3

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    fail "Max balance #{MAX_BALANCE} reached" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end

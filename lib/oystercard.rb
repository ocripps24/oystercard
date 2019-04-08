
class Oystercard
attr_reader :balance
attr_reader :card_in_user

MAX_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
    @card_in_use = false
  end

  def top_up(amount)
    fail "Max balance #{MAX_BALANCE} reached" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @card_in_use = true
  end

  def touch_out
    @card_in_use = false
  end

  def in_journey?
    return card_in_use
  end

end

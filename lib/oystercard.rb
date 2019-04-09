
class Oystercard
attr_reader :balance
attr_reader :card_in_use

MAX_BALANCE = 90
MIN_BALANCE = 1
MIN_CHARGE = -3

  def initialize(balance = 0)
    @balance = balance
    @card_in_use = false
    @entry_station = nil
  end

  def top_up(amount)
    fail "Max balance #{MAX_BALANCE} reached" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Balance below minimum" if @balance < MIN_BALANCE
    @card_in_use = true
    @entry_station = station
  end

  def touch_out
    @card_in_use = false
    deduct(-MIN_CHARGE)
  end

  def in_journey?
    return card_in_use
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end

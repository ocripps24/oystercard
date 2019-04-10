
class Oystercard
attr_reader :balance
attr_reader :entry_station

MAX_BALANCE = 90
MIN_BALANCE = 1
MIN_CHARGE = 3

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
  end

  def top_up(amount)
    fail "Max balance #{MAX_BALANCE} reached" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Balance below minimum" if @balance < MIN_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct(MIN_CHARGE)
    @entry_station = nil
  end

  def in_journey?
    # !!entry_station
    if @entry_station == nil
      return false
    else
      return true
    end
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end

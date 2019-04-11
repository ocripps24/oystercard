
class Oystercard
attr_reader :balance
attr_reader :entry_station
attr_reader :exit_station
attr_reader :journies

MAX_BALANCE = 90
MIN_BALANCE = 1
MIN_CHARGE = 3

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @journies = []
  end

  def top_up(amount)
    fail "Max balance #{MAX_BALANCE} reached" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(in_station)
    fail "Balance below minimum" if @balance < MIN_BALANCE
    @entry_station = in_station
    @exit_station = nil
    # journey = { entrance: in_station}
    # journey[]
    # @journies << journey
  end

  def touch_out(out_station)
    deduct(MIN_CHARGE)
    @entry_station = nil
    @exit_station = out_station
    # @journey = {}
    # @journey[exit_station] = out_station
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

class Journey

  attr_reader :entry_station, :exit_station, :journies

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 3

  def initialize(argument)
    @entry_station = nil
    @exit_station = nil
    @journies = []
  end

  def touch_in(in_station)
    fail "Balance below minimum" if @balance < MIN_BALANCE
    @entry_station = in_station
    @exit_station = nil
  end

  def touch_out(out_station)
    deduct(MIN_CHARGE)
    @exit_station = out_station
    journey = { entrance: entry_station, exit: exit_station }
    @journies << journey
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

end

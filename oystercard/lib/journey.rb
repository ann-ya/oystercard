class Journey

  attr_reader :entry_station, :exit_station

  PENALTY_FARE = 6
  MIN_CHARGE = 1

  def start
    @entry_station = entry_station
    # @complete = false
  end

  def finish(exit_station = nil)
    @exit_station = exit_station
    @complete
  end

  def complete?
    @complete = true
  end

  def fare
    MIN_CHARGE
  end

  private
  def penalty?

  end

end
class Bank
  DEFAULT_BANK_SUM = 100
  BET = 10

  @@bet_sum = 0
  attr_reader :sum

  def initialize
    @sum = DEFAULT_BANK_SUM
  end

  def do_bet!
    @sum -= BET
    @@bet_sum += BET
  end

  def add(value)
    @sum += value
  end

  def self.reset_bet_sum
    @@bet_sum = 0
  end

  def self.bet_sum
    @@bet_sum
  end
end

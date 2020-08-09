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

  def add_winning_price!
    @sum += @@bet_sum
    Bank.reset!
  end

  def add_bet!
    @sum += BET
    Bank.reset!
  end

  def self.bet_sum
    @@bet_sum
  end

  def self.reset!
    @@bet_sum = 0
  end
end

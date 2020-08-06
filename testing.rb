require './card.rb'
require './player.rb'
require './bank.rb'

def test(test_number, condition, msg = '')
  puts condition ? "#{test_number}  |TRUE |  #{msg}" : "#{test_number} [[FALSE]] #{msg}"
end

# T1 CARD AND HAND VALUE
c1 = Card.new(:clubs, 10)
c2 = Card.new(:clubs, 'K')
c3 = Card.new(:clubs, 'A')

p1 = Player.new
p1 << c1
p1 << c2
p1 << c3
p2 = Player.new
p2 << c2
p2 << c3

test 1, p1.hand_value == 21, 'hend value count'
test 1, p2.hand_value == 21, 'hend value count'

# T2 BANK

b1 = Bank.new
b2 = Bank.new

b1.do_bet
b2.do_bet

test 2, Bank.bet_sum == 20, 'Bet sum'
test 2, b1.sum == 90, 'Bank sum'

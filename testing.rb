require './card.rb'
require './player.rb'

def test(test_number, condition, msg = '')
  puts condition ? "#{test_number}  |TRUE |  #{msg}" : "#{test_number} [[FALSE]] #{msg}"
end

#T1 
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

test 1, p1.hand_value == 21, 'Check hend value count'
test 1, p2.hand_value == 21, 'Check hend value count'

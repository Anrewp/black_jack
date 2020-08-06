require './card.rb'
require './player.rb'
require './bank.rb'
require './deck.rb'

def test(test_number, condition, msg = '')
  puts condition ? "#{test_number}  |TRUE |  #{msg}" : "#{test_number} [[FALSE]] #{msg}"
end

# T1 CARD AND HAND VALUE
c10 = Card.new(:clubs, 10)
ck = Card.new(:clubs, 'K')
ca = Card.new(:clubs, 'A')

deck1 = Deck.new [c10, ck, ca]
deck2 = Deck.new [ck, ca]

p1 = Player.new
p1.hit!(deck1)
p1.hit!(deck1)
p1.hit!(deck1)

p2 = Player.new
p2.hit!(deck2)
p2.hit!(deck2)

test 1, p1.hand_value == 21, 'hend value count'
test 1, p2.hand_value == 21, 'hend value count'

# T2 BANK

b1 = Bank.new
b2 = Bank.new

b1.do_bet
b2.do_bet

test 2, Bank.bet_sum == 20, 'Bet sum'
test 2, b1.sum == 90, 'Bank sum'

# T3 DECK
deck = Deck.new

test 3, deck.cards.size == 52, 'Build deck'

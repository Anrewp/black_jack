require './card.rb'
require './player.rb'
require './bank.rb'
require './deck.rb'
require './game.rb'

def test(test_number, condition, msg = '')
  puts condition ? "#{test_number}  |TRUE |  #{msg}" : "#{test_number} [[FALSE]] #{msg}"
end

# T1 CARD AND HAND VALUE
c10 = Card.new(:clubs, 10)
ck = Card.new(:clubs, 'K')
ca = Card.new(:clubs, 'A')
c2 = Card.new(:clubs, 2)

deck1 = Deck.new [c10, ck, ca]
deck2 = Deck.new [ck, ca]

p1 = Player.new('Bob', Bank.new)
p1.hit!(deck1)
p1.hit!(deck1)
p1.hit!(deck1)

p2 = Player.new('Pit', Bank.new)
p2.hit!(deck2)
p2.hit!(deck2)

test 1.1, p1.hand_value == 21, 'hend value count'
test 1.2, p2.hand_value == 21, 'hend value count'

# T2 BANK

b1 = Bank.new
b2 = Bank.new

b1.do_bet!
b2.do_bet!

test 2.1, Bank.bet_sum == 20, 'Bet sum'
test 2.2, b1.sum == 90, 'Bank sum'

# T3 DECK
deck = Deck.new

test 3.0, deck.cards.size == 52, 'Build deck'

# Game Test
Bank.reset!
player = Player.new('Andrew', Bank.new)
diller = Player.new('Diller', Bank.new)
fake_decks = [Deck.new([c10, c2, ca, ck]),
              Deck.new([c2, c2, ck, ca]),
              Deck.new([ck, c2, ck, ck]),
              Deck.new([ca, c2, ck, ck])]

4.times.with_index do |_time, index|
  fake_deck = fake_decks[index]
  game = Game.new(player, diller, fake_deck)
  game.start_game
  game.determen_winner
  index != 3 || test(4.0, game.player.bank.sum == 120 && game.diller.bank.sum == 80, 'Player bank after games check')
end

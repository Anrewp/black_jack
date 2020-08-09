class Player
  attr_reader :cards, :bank, :name

  def initialize(player_name, bank)
    @cards = []
    @bank = bank
    @name = player_name
  end

  def hit!(deck)
    card = deck.cards.shift
    card.ace? ? @cards << card : @cards.insert(0, card)
  end

  def do_bet!
    @bank.do_bet!
  end

  def hand_value
    @cards.inject(0) do |sum, card|
      sum += if card.ace?
               (sum + card.value) <= 21 ? card.value : 1
             else
               card.value
             end
    end
  end

  def reset_hand!
    @cards = []
  end
end

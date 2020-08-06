class Player
  attr_reader :cards

  def initialize
    @cards = []
  end

  def <<(card)
    card.ace? ? @cards << card : @cards.insert(0, card)
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
end

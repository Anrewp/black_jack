class Deck
  SUITS = %i[clubs diamonds spades hearts].freeze
  NUMBERS = (2..10).freeze
  FACECARDS = %w[J Q K A].freeze

  attr_reader :cards

  def initialize(fake_deck = nil)
    @cards = fake_deck || build_deck
  end

  private

  def build_deck
    cards = []
    SUITS.each do |suit|
      NUMBERS.each do |number|
        cards << Card.new(suit, number)
      end
      FACECARDS.each do |facecard|
        cards << Card.new(suit, facecard)
      end
    end
    cards.shuffle
  end
end

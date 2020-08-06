class Card
  SUIT_MARKS = { spades: "\u2664", hearts: "\u2661", clubs: "\u2667", diamonds: "\u2662" }.freeze

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def value
    case @value
    when 'J', 'Q', 'K' then 10
    when 'A' then 11
    else @value
    end
  end

  def to_s
    "[#{@value}#{SUIT_MARKS[@suit]} ]"
  end

  def ace?
    @value == 'A'
  end
end

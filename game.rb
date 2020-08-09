class Game
  MAX_CARDS = 3
  MAX_VALUE = 21
  AVERAGE_VALUE = 17

  attr_reader :player, :diller, :deck

  def initialize(player, diller, deck)
    @player = player
    @diller = diller
    @deck = deck
  end

  def start_game
    player.do_bet! && diller.do_bet!
    2.times { @player.hit!(@deck) && @diller.hit!(@deck) }
  end

  def skip!
    #NI
    diller_move
  end

  def hit!
    # Only if 2 cards
    return if @player.cards.size == MAX_CARDS

    @player.hit!(@deck)
  end

  def determen_winner
    player_hand_value = @player.hand_value
    diller_hand_value = @diller.hand_value
    case player_hand_value
    when 4..21
      return winner(@player) if diller_hand_value > MAX_VALUE

      if player_hand_value > diller_hand_value
        winner(@player)
      elsif player_hand_value == diller_hand_value
        add_bank_sum_to_winner
        'draw'
      else
        winner(@diller)
      end
    else
      winner(@diller)
    end
  end

  private

  def winner(player)
    add_bank_sum_to_winner(player)
    player.name
  end

  def add_bank_sum_to_winner(player = nil)
    if player
      player.bank.add(Bank.bet_sum)
    else
      @player.bank.add(Bank::BET) && @diller.bank.add(Bank::BET)
    end
    Bank.reset_bet_sum
  end

  def diller_move
    return if @diller.cards.size == MAX_CARDS || @diller.hand_value >= AVERAGE_VALUE

    @diller.hit!(@deck)
  end
end

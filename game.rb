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

  def player_skip!
    diller_move
  end

  def player_hit!
    return if max_cards?(@player)

    @player.hit!(@deck)
    diller_move
  end

  def determen_winner
    player_hand_value = @player.hand_value
    diller_hand_value = @diller.hand_value
    return winner(@diller) if player_hand_value > MAX_VALUE
    return winner(@player) if diller_hand_value > MAX_VALUE

    if    player_hand_value >  diller_hand_value then winner(@player)
    elsif player_hand_value == diller_hand_value then winner
    else  winner(@diller)
    end
  end

  def max_cards?(player)
    player.cards.size == MAX_CARDS
  end

  private

  def winner(player = nil)
    add_bank_sum_to_winner(player)
    reset_player_hands
    player ? player.name : 'draw'
  end

  def add_bank_sum_to_winner(player = nil)
    if player
      player.bank.add_winning_price!
    else
      @player.bank.add_bet! && @diller.bank.add_bet!
    end
  end

  def reset_player_hands
    @diller.reset_hand! && @player.reset_hand!
  end

  def diller_move
    return if max_cards?(@diller) || @diller.hand_value >= AVERAGE_VALUE

    @diller.hit!(@deck)
  end
end

class Interface
  MAX_SKIPS = 5

  def initialize
    @player_name = 'Player'
    @skip_counter = 0
  end

  def run
    init_game
    loop do
      begin
        break if press_enter_to_continue['0']

        new_game if Bank.bet_sum.zero?
        show_table
        make_choice
        auto_determen_winner
      rescue StandardError => e
        puts e.message
      end
    end
  end

  private

  def show_table
    puts `clear`
    show_winner
    puts ''
    puts '         __TABLE__'
    puts ' ----------------------------'
    puts "|BET: #{Bank.bet_sum}$              Diller"
    puts "|                      diller bank: #{diller.bank.sum}$"
    puts "|                      #{show_diller_hand}"
    puts '|'
    puts "| #{player.name}"
    puts "| your bank: #{player.bank.sum}$"
    puts "| #{show_player_hand}"
    puts ' ----------------------------'
    puts '| |                        | |'
    puts '|_|                        |_|'
    puts ''
    show_hand_value
    puts ''
    @skip_counter += 1
  end

  def make_choice
    choices
    choice = gets.chomp.to_i
    case choice
    when 1 then @game.player_skip!
    when 2 then @game.player_hit!
    when 3 then determen_winner
    else raise  StandardError, 'No such option'
    end
  end

  # ---------- SHOW ----------------

  def show_winner
    return unless Bank.bet_sum.zero?

    case @winner
    when 'Diller' then you_lose
    when 'draw'   then draw
    else you_win
    end
  end

  def show_hand_value
    puts "---- Your hand value: #{player.hand_value}" unless Bank.bet_sum.zero?
  end

  def show_player_hand
    Bank.bet_sum.zero? ? show_cards(@player_hand) : show_cards(player.cards)
  end

  def show_diller_hand
    Bank.bet_sum.zero? ? show_cards(@diller_hand) : show_hidden_cards
  end

  def show_hidden_cards
    hand = ''
    diller.cards.each { |_card| hand += '[X]' }
    hand
  end

  def show_cards(cards)
    hand = ''
    cards.each { |card| hand += card.to_s }
    hand
  end

  def diller
    @game.diller
  end

  def player
    @game.player
  end

  # ---------- GAME ---------------

  def auto_determen_winner
    determen_winner if @game.max_cards?(player) && @game.max_cards?(diller) || @skip_counter >= MAX_SKIPS
  end

  def determen_winner
    @diller_hand = diller.cards
    @player_hand = player.cards
    @winner = @game.determen_winner
    @skip_counter = 0
    show_table
  end

  def init_game
    black_jack_logo
    enter_name
    @diller = Player.new('Diller', Bank.new)
    @player = Player.new(@player_name, Bank.new)
  end

  def new_game
    @game = Game.new(@player, @diller, Deck.new)
    @game.start_game
  end

  def press_enter_to_continue
    puts 'Press enter to continue or 0 to Exit'
    gets.chomp
  end

  def enter_name
    puts 'Welcome to Blak Jack game!'
    puts 'Enter your name to start game'
    print 'name: '
    name = gets.chomp.to_s
    @player_name = name unless name.empty?
  end

  # ---------- TEXT ---------------

  def choices
    puts ''
    puts 'Make a choice'
    puts '- press 1 to skip turn'
    puts '- press 2 to hit deck' if player.cards.size != Game::MAX_CARDS
    puts '- press 3 to open hand'
  end

  def black_jack_logo
    puts ''
    puts '█▄▄ █░░ ▄▀█ █▄▀   ░░█ ▄▀█ █▀▀ █▄▀   █▀▀ ▄▀█ █▀▄▀█ █▀▀'
    puts '█▄█ █▄▄ █▀█ █░█   █▄█ █▀█ █▄▄ █░█   █▄█ █▀█ █░▀░█ ██▄'
    puts '-----------------------------------------------------'
  end

  def you_win
    puts '    █▄█ █▀█ █░█   █░█░█ █ █▄░█ █'
    puts '    ░█░ █▄█ █▄█   ▀▄▀▄▀ █ █░▀█ ▄'
  end

  def you_lose
    puts '    █▄█ █▀█ █░█   █░░ █▀█ █▀ █▀▀ █'
    puts '    ░█░ █▄█ █▄█   █▄▄ █▄█ ▄█ ██▄ ▄'
  end

  def draw
    puts '    █▀▄ █▀█ ▄▀█ █░█░█'
    puts '    █▄▀ █▀▄ █▀█ ▀▄▀▄▀'
  end
end

class Interface
  def initialize
    # :not_implemented
    @player_name = ''
  end

  def run
    black_jack_logo
    enter_name
    loop do
      break if press_enter_to_continue['0']
      puts @player_name
    end
  end

  private

  def press_enter_to_continue
    puts 'press enter to continue'
    gets.chomp
  end

  def black_jack_logo
    puts ''
    puts '█▄▄ █░░ ▄▀█ █▄▀   ░░█ ▄▀█ █▀▀ █▄▀   █▀▀ ▄▀█ █▀▄▀█ █▀▀'
    puts '█▄█ █▄▄ █▀█ █░█   █▄█ █▀█ █▄▄ █░█   █▄█ █▀█ █░▀░█ ██▄'
    puts '-----------------------------------------------------'
  end

  def enter_name
    puts 'Enter your name: '
    @player_name = gets.chomp.to_s
  end
end

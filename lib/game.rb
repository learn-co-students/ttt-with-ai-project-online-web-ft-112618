class Game
  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0,1,2], #Top row
    [3,4,5], #Middle row
    [6,7,8], #Bottom row
    [0,3,6], #Left-vert row
    [1,4,7], #Middle-vert row
    [2,5,8], #Right-vert row
    [0,4,8], #Left-diagnol row
    [2,4,6] #Right-diagnol row
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    self.player_1 = player_1
    self.player_2 = player_2
    self.board = board
  end

  def current_player
    self.board.turn_count.even? ? self.player_1 : self.player_2
  end

  def won?
    WIN_COMBINATIONS.detect do |combination|

      self.board.cells[combination[0]] == self.board.cells[combination[1]] && self.board.cells[combination[1]] == self.board.cells[combination[2]] && self.board.taken?(combination[0] + 1)
    end
  end

  def draw?
    won? == nil && self.board.full?
  end

  def over?
    draw? || won?
  end

  def winner
    if self.won?
      self.board.cells[self.won?.first]
    end
  end

  def turn
    player = current_player
    current_move = player.move(self.board)
    if !self.board.valid_move?(current_move)
      turn
    else
      puts "Turn: #{self.board.turn_count + 1}"
      self.board.update(current_move, player)
      puts "#{player.token} moved #{current_move}"
      self.board.display
      puts "\n\n"
    end
  end

  def play
    while !over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end

class Game
  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], #horizontal
    [0, 3, 6], [1, 4, 7], [2, 5, 8], #vertical
    [0, 4, 8], [2, 4, 6]
  ]

  def initialize (p1: "human", p2: "human", board: nil)
    if p1 == "comp"
      @player_1 = Players::Computer.new("X")
    elsif p1 == "human"
      @player_1 = Players::Human.new("X")
    else
      @player_1 = p1
    end
    if p2 == "comp"
      @player_2 = Players::Computer.new("O")
    elsif p2 == "human"
      @player_2 = Players::Human.new("O")
    else
      @player_2 = p2
    end
    board ? @board = board : @board = Board.new
  end


  def board
    @board
  end

  def current_player
    self.board.turn_count.even? ? self.player_1 : self.player_2
  end

  def won? #if win, return winning indices, otherwise return false
    x = WIN_COMBINATIONS.select do |array|
      array.all? {|i| self.board.cells[i] == "X"} || array.all? {|i| self.board.cells[i] == "O"}
    end
    x.empty? ? false : x.flatten
  end

  def draw?
    self.board.full? && !self.won?
  end

  def over?
    self.draw? || self.won?
  end

  def winner
    if self.won?
      self.board.cells[self.won?[0]]
    else
      nil
    end
  end

  def turn
    self.board.display
    self.current_player == self.player_1 ? x = 1 : x = 2
    puts "\n#{self.current_player.name} \##{x}. Where do you want to move?"
    position = self.current_player.move(board)
    if self.board.valid_move?(position)
      self.board.update(position, self.current_player)
    else
      puts "That move isn't valid, please try again!"
      binding.pry
      self.turn
    end
  end

  def play
    if self.over? == false
      self.turn
      self.play
    elsif self.won?
      self.board.display
      self.current_player == self.player_1 ? x = 2 : x = 1
      puts "\nCongratulations, Player \##{x}!"
    else
      self.board.display
      puts "\nCat's Game!"
    end
  end

end

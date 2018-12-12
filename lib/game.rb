class Game
  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], #horizontal
    [0, 3, 6], [1, 4, 7], [2, 5, 8], #vertical
    [0, 4, 8], [2, 4, 6]
  ]

  def initialize (p1 = nil, p2 = nil, board = nil)
    p1 ? @player_1 = p1 : @player_1 = Players::Human.new("X")
    p2 ? @player_2 = p2 : @player_2 = Players::Human.new("O")
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
    puts "Where do you want to move?"
    input = self.current_player.move(board)
    position = self.board.position(input)
    if !(self.board.taken?(position))
      self.board.update(position, self.current_player)
    else
      self.turn
    end
  end

end





#save for AI

# moved = false
# until moved == true
#   x = rand(1..9)
#   if !(self.board.taken?(rand(1..9)))
#     self.board.update(x, self.player)
#     moved = true
#   end
# end

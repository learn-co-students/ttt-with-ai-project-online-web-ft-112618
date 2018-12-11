class Game
  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], #horizontal
    [0, 3, 6], [1, 4, 7], [2, 5, 8], #vertical
    [0, 4, 8], [2, 4, 6]
  ]

  def initialize
    self.board = Board.new
    self.player_1 = Players::Human.new
    self.player_2 = Players::Human.new
  end


end

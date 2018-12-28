require 'pry'
class Board
  attr_accessor :cells

  def initialize
    self.cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def reset!
    self.cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display
      puts " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} "
      puts "-----------"
      puts " #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} "
      puts "-----------"
      puts " #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
  end

  def position(input)
    self.cells[input.to_i - 1]
  end

  def full?
    self.cells.all? {|cell| cell != " "}
  end

  def turn_count
    self.cells.count {|cell| cell != " "}
  end

  def taken?(input)
    self.cells[input.to_i - 1] != " "
  end

  def valid_move?(input)
    input.to_i.between?(1, 9) && self.taken?(input) == false
  end

  def update(input, player)
    if valid_move?(input)
      self.cells[input.to_i - 1] = player.token
    end
  end

end

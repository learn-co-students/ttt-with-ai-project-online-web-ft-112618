class Board
  attr_accessor :cells

  def initialize
    self.reset!
  end

  def reset!
    @cells = Array.new(9, " ")
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

  def update(position, player)
    self.cells[position.to_i - 1] = player.token
  end

  def full?
    self.cells.none?(" ")
  end

  def turn_count
    self.cells.reject {|x| x == " "}.size
  end

  def taken?(position)
    !!self.position(position).match(/[OX]/)
  end

  def valid_move?(position)
    !self.taken?(position) && (1..9).include?(position.to_i)
  end


end

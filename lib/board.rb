class Board
  attr_accessor :cells
  include Players

  def initialize
    reset!
  end

  # exlamations points usually mean something is being forced to happen
  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    puts "-----------"
    puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    puts "-----------"
    puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    puts "-----------"
    puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
  end

  # -1 b/c humans start counting from one, computers from zero
  def position(input)
    cells[input.to_i-1]
  end

  # question mark in a method name usually means the method will return true or false
  def full?
    cells.all?{|c| c == "X" || c == "O"} # .all will send every value in the array through a loop to see what's in each position
  end

  def turn_count
    cells.count("X") + cells.count("O") # cells.count{\c\ c == "X" || c == "O"} also works
  end

  def taken?(input)
    position(input) == "X" || position(input) == "O"
  end

  def valid_move?(input)
    input.to_i.between?(1, 9) && !taken?(input)
  end

  def update(input, player)
    cells[input.to_i-1] = player.token # X or O depending on which thep layer enters
  end

end

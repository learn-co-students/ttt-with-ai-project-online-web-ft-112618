class Players::Human < Player
  attr_accessor :player

  def move(board)
    puts "Please enter 1-9:"
    gets.strip
  end

end

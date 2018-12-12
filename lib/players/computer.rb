module Players
  class Computer < Player

    def initialize(token)
      super
    end


    def move(board)
      #x looks for a situation where the computer can play a winning move
      x = Game::WIN_COMBINATIONS.each.with_object("") do |array, s|
        if s.to_i == 0 && array.reject {|i| board.cells[i] == " "}.size == 2 && array.reject {|i| board.cells[i] == " "}.all? {|i| board.cells[i] == self.token}
          s << (array.find {|i| board.cells[i] == " "} + 1).to_s
        end
      end
      #y looks for a situation where the opponent can play a winning move
      y = Game::WIN_COMBINATIONS.each.with_object("") do |array, s|
        if s.to_i == 0 && array.reject {|i| board.cells[i] == " "}.size == 2 && array.map {|i| board.cells[i]}.uniq.size == 2
          s << (array.find {|i| board.cells[i] == " "} + 1).to_s
        end
      end
      if board.valid_move?(x) #prioritizes a win over avoiding a loss
        x
      elsif board.valid_move?(y) #prioritizes avoiding a loss over a non-winning move
        y
      elsif board.valid_move?("5") #priorizes the center as a strategic position
        "5"
      elsif (["1", "3", "7", "9"].find_all {|i| board.valid_move?(i)}.size) > 2 || board.cells.map.with_index{|x, i| i unless x == " "}.compact == [0, 4, 8] || board.cells.map.with_index{|x, i| i unless x == " "}.compact == [2, 4, 6]
        #prioritizes the corners except for one scenario with one exception:
          #one) a strategic trap where the opponent occupies two opposite corners
          #and is hoping that the computer will also pick one of the two empty corners
          #two) the one exception is when the opponent occupies one corner & the center
          #and the computer occupies the opposite corner along the same diagonal.
          # In this case, it is an exception to the rule stated above, as the computer SHOULD
          # play one of the corners to avoid a different strategic trap
        x = ["1", "3", "7", "9"].find_all {|i| board.valid_move?(i)}
        x.sample
      else #in this final scenario, unless circumstances have forced the computer to avoid
        #playing a corner until the very end, then only the non-corner, non-center options remain
        #so it samples randomly from those options.
        #The right side of the or-operator allows the computer to pick a corner if that is the only
        #remaining option.
        ["2", "4", "6", "8"].find_all {|i| board.valid_move?(i)}.sample || Array.new(9) {|i| (i + 1).to_s}.find_all {|i| board.valid_move?(i)}.sample
      end
    end

    def name
      "Computer player"
    end

  end
end

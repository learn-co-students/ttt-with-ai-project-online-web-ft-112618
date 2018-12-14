module Players
  class Human < Player

    def initialize(token)
      super
    end

    def move(board)
      input = gets.strip
    end

    def name
      "Player"
    end

  end
end

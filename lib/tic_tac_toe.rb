class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def input_to_index (user_input)
    index = user_input.to_i - 1
  end

  def move (index, current_player = "X")
      @board[index] = current_player
  end

  def valid_move?(index)
    index.between?(1,9) && !position_taken?(index)
  end

  def won?()
    WIN_COMBINATIONS.detect do |combo|
      @board[combo[0]] == @board[combo[1]] &&
      @board[combo[1]] == @board[combo[2]] &&
      position_taken?(combo[0])
    end
  end

  def full?()
    @board.all?{|token| token == "X" || token == "O"}
  end

  def draw?()
    !won?() && full?()
  end

  def over?()
    won?() || draw?()
  end

  def turn(index)
    puts "Please enter 1-9:"
    index=input_to_index(user_input.gets)
    if !valid_move?(index)
      turn()
    end
    move(index, current_player)
    display_board()
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def play()
    if over?()==false
      turn()
      play()
    else
      if draw?()
        puts "Cat's Game!"
      elsif won?()!=nil
        puts "Congratulations #{winner(board)}!"
      end
    end
  end
end

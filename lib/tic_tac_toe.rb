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
    input.to_i.between?(1,9) && !position_taken?(index)
  end

  def won?(board)
    WIN_COMBINATIONS.detect do |combo|
      board[combo[0]] == board[combo[1]] &&
      board[combo[1]] == board[combo[2]] &&
      position_taken?(board, combo[0])
    end
  end

  def full?(board)
    board.all?{|token| token == "X" || token == "O"}
  end

  def draw?(board)
    won?(board) && full?(board)
  end

  def over?(board)
    won?(board) || draw?(board)
  end

  def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    if !valid_move?(board, input)
      turn(board)
    end
    move(board, input, current_player(board))
    display_board(board)
  end

  def position_taken?(board, index)
    !(board[index].nil? || board[index] == " ")
  end

  def play(board)
    if over?(board)==false
      turn(board)
      play(board)
    else
      if draw?(board)
        puts "Cat's Game!"
      elsif won?(board)!=nil
        puts "Congratulations #{winner(board)}!"
      end
    end
  end
end

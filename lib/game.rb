class Game

  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [[0,1,2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [2, 5, 8], [1, 4, 7], [0, 4, 8], [2, 4, 6]]

  def initialize(player_1 = Players::Human.new, player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    @board.turn_count.even? ? @player_1 : @player_2
  end

  def over?
    draw? || won?
  end

  def won?
    WIN_COMBINATIONS.find{|combo| combo.all? {|cell| @board.cells[cell] == "X"} || combo.all? {|cell| @board.cells[cell] == "O"}}
  end

  def draw?
    @board.full? && !won?
  end

  def winner
    @board.cells[won?.first] if won?
  end

  def turn
    @board.display
    input = (current_player.move(@board))
    @board.valid_move?(input) ? @board.update(input, current_player) : turn
  end

  def play
    turn until over?
    @board.display
    draw? ? (puts "Cat's Game!") : (puts "Congratulations #{winner}!")
  end

end

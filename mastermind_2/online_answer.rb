class MasterMind

  def guess?
    puts "MasterMind: Do you got it? \n============================\n"
    legend
    puts "==========================\n"
    puts "Do you want think you can HAL9000 - (g)uess or (m)ake code?"
    input = gets.chomp.downcase
    return true if input == 'g'
    return false if input == 'm'
    puts "Didn't understand that.."
    return guess?
  end

  def play
    @turn = 1
    @guess_board = make_board
    @rate_board = make_board
    guess? ? flow('human') : flow('ai')
  end

  def flow(player)
    @truth = player == 'human' ? AI.make_code : Human.make_code

    12.times do |n|
      @turn = n + 1

      if player == 'human'
        @guess_board[@turn] = Human.guess
      else
        @ai = AI.new if @turn == 1
        @guess_board[@turn] = @ai.guess(@turn, @rate_board, @guess_board)
      end

      if right_guess?
        puts 'You win!'
        break
      end
      @rate_board[@turn] = turn_results
      print_board
    end

    puts "\nThe answer was: #{@truth.join(",")}"
    puts "You lose!" if @turn == 12
  end

  def print_board
    puts "=========================="
    @turn.downto(1).each do |n|
      puts "|##{n}| #{@guess_board[n].join(",")} || #{@rate_board[n].join(",")} ||"
    end
    puts "==========================\n"
  end

  def make_board
    [['x']*4]*12
  end

  def legend
    puts "Legend: a '2' indicates a correction color and position, a '1' means a right color, and a '0' means incorrect color and position."
  end

  def correct_positions
    count = 0
    (0..3).each do |n|
      count += 1 if (@guess_board[@turn][n] == @truth[n])
    end
    count
  end

  def correct_colors
    count = 0
    truth = @truth.clone
    @guess_board[@turn].each do |n|
      if truth.include?(n)
        count += 1
        truth.delete_at(truth.index(n))
      end
    end
    count
  end

  def turn_results
    result = []
    correct_positions.times {result << 2}
    (correct_colors - correct_positions).times {result << 1}
    (4 - result.size).times {result << 0}
    result
  end

  def right_guess?
    @guess_board[@turn] == @truth
  end

end

class AI

  def self.make_code
    choices = 'rgybmc'.split('')
    truth = [choices[rand(5)],choices[rand(5)],choices[rand(5)],choices[rand(5)]]
  end

  def guess(n, rate_board, guess_board)
    if n == 1
      make_all_choices
      return 'rrgg'.split('') 
    end
    act_on_feedback(n, rate_board, guess_board)
    #choices = 'rgybmc'.split('')
    #[choices[rand(5)],choices[rand(5)],choices[rand(5)],choices[rand(5)]]
  end

  def act_on_feedback(n, rate_board, guess_board)
    last_feedback = rate_board[n-1]
    last_guess = guess_board[n-1]

    modify_choices(0, last_guess, last_feedback)
    modify_choices(1, last_guess, last_feedback)
    modify_choices(2, last_guess, last_feedback)
    modify_choices(3, last_guess, last_feedback)
    modify_choices(4, last_guess, last_feedback)

    @all_choices[rand(@all_choices.size)]
  end

  def modify_choices(num_zeros, last_guess, last_feedback)
    if last_feedback.count(0) == num_zeros
      keep = []
      @all_choices.each do |choice|
        keep << choice if num_correct_colors(last_guess, choice) == (4 - num_zeros)
      end
      @all_choices = keep - [last_guess]
    end
  end

  def num_correct_colors(last_guess, choice)
    count = 0
    temp_guess = last_guess.clone
    choice.each do |n|
      if temp_guess.include?(n)
        count += 1
        temp_guess.delete_at(temp_guess.index(n))
      end
    end
    count
  end

  def make_all_choices
    @all_choices = []
    choices = 'rgybmc'.split('')
    (0..5).each do |n1|
      (0..5).each do |n2|
        (0..5).each do |n3|
          (0..5).each do |n4|
            @all_choices << [choices[n1],choices[n2],choices[n3],choices[n4]]
          end
        end
      end
    end
    @all_choices
  end

end

class Human

  def self.make_code
    puts "What's the code, smarty-pants? Enter 4: (R)ed, (G)reen, (Y)ellow, (B)lue, (M)agenta, and (C)yan."
    input = gets.chomp.downcase.scan(/[rgybmc]/).map {|n| n}
    return input if input.size == 4
    puts "That doesn't make sense..come on, try again.\n"
    return make_code
  end

  def self.guess
    puts "What's your guess? Enter 4: (R)ed, (G)reen, (Y)ellow, (B)lue, (M)agenta, and (C)yan."
    input = gets.chomp.downcase.scan(/[rgybmc]/).map {|n| n}
    return input if input.size == 4
    puts "That doesn't make sense..come on, try again.\n"
    return guess
  end

end

game = MasterMind.new.play
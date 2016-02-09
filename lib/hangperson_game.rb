class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
    
  def initialize(new_word)
    @word = new_word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def letter?(word)
    ('a'..'z').to_a.include? (word.downcase)
  end
  
  def guess(my_guess)
    raise ArgumentError if (my_guess.nil? || my_guess == '' || !letter?(my_guess))
    
    my_guess = my_guess.downcase
    if @word.include? (my_guess)
      if @guesses.include? (my_guess)
        return false
      else
        @guesses << my_guess
        return true
      end
    else
      if @wrong_guesses.include? (my_guess)
        return false
      else
        @wrong_guesses << my_guess
        return true
      end
    end
  end
  
  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if self.word_with_guesses == @word
    return :play
  end
  
  def word_with_guesses
    word_so_far = ''
    @word.split('').each do |letter|
      if @guesses.include?(letter)
        word_so_far << letter
      else
        word_so_far << '-'
      end
    end
    return word_so_far
  end

end

require "hangperson/version"

module Hangperson
  class Game
    attr_reader :word, :guesses, :wrong_guesses

    def initialize
      @word = get_random_word
      @guesses = []
      @wrong_guesses = []
    end

    def guess(char)
      raise ArgumentError unless char&.match(/\A[a-zA-Z]+\z/)
      char.downcase!
      return if (guesses + wrong_guesses).include? char
      if word.include?(char)
        guesses << char
      else
        wrong_guesses << char
      end
    end

    def word_with_guesses
      word.chars.map { |char| guesses.include?(char) ? char : '-' }.join
    end

    def win?
      word_with_guesses == word
    end

    def lose?
      wrong_guesses.size == 7
    end

    private

    def get_random_word

    end
  end
end

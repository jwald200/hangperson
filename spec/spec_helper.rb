require "bundler/setup"
require "hangperson"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def set_random_word_to(word)
  allow_any_instance_of(Hangperson::Game).to receive(:get_random_word).
    and_return(word)
end

def guess_several_letters(game, letters)
  letters.chars do |char|
    game.guess(char)
  end
end

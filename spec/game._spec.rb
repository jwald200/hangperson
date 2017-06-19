RSpec.describe Hangperson do
  let(:hangperson) { Hangperson::Game.new }

  describe '#word' do
    it 'has a radom word' do
      set_random_word_to 'hello'

      expect(hangperson.word).to eq('hello')
    end
  end

  describe '#guesses' do
    it 'returns an empty array before any successful guesses' do
      expect(hangperson.guesses).to be_an Array
    end
  end

  describe '#wrong_guesses' do
    it 'returns an empty array before any wrong guesses' do
      expect(hangperson.wrong_guesses).to be_an Array
    end
  end

  describe '#guess' do
    context 'invalid input' do
      it 'raises ArgumentError for nil, empty string, and non-alphabet chars' do
        [nil, '', '9'].each do |invalid_input|
          expect { hangperson.guess(nil) }.to raise_error(ArgumentError)
        end
      end
    end

    context 'successfully' do
      it 'adds the char to #guesses' do
        set_random_word_to 'hello'
        hangperson.guess('h')

        expect(hangperson.guesses).to include('h')
      end
    end

    context 'wrong guess' do
      before do
        set_random_word_to 'hello'
        hangperson.guess('a')
      end

      it 'does not add char to #guesses' do
        expect(hangperson.guesses).not_to include('a')
      end

      it 'adds wrong guesses to #wrong_guesses' do
        expect(hangperson.wrong_guesses).to include('a')
      end
    end

    context 'repeated input' do
      it 'ignores guesses' do
        set_random_word_to 'hello'
        hangperson.guess('h')

        expect { hangperson.guess('h') }.not_to change { hangperson.guesses }
      end

      it 'ignores wrong guesses' do
        set_random_word_to 'hello'
        hangperson.guess('a')

        expect { hangperson.guess('a') }.not_to change { hangperson.wrong_guesses }
      end

      it 'returns nil' do
        set_random_word_to 'hello'
        hangperson.guess('a')
        hangperson.guess('h')

        expect(hangperson.guess('a')).to be_nil
        expect(hangperson.guess('h')).to be_nil
      end
    end

    context 'uppercase input' do
      it 'converts input lowercase' do
        set_random_word_to 'hello'
        hangperson.guess('A')
        hangperson.guess('H')

        expect(hangperson.guesses).not_to include('H')
        expect(hangperson.guesses).to include('h')
        expect(hangperson.wrong_guesses).not_to include('A')
        expect(hangperson.wrong_guesses).to include('a')
      end
    end
  end

  describe '#word_with_guesses' do
    before { set_random_word_to 'hello' }


    test_cases = {
      'hl' =>  'h-ll-',
      'was' => '-----',
      'helo' => 'hello'
    }
    test_cases.each do |guesses, displayed|
      it "should be '#{displayed}' when guesses are '#{guesses}'" do
        guess_several_letters(hangperson, guesses)
        expect(hangperson.word_with_guesses).to eq(displayed)
      end
    end
  end

  describe '#win?' do
    before { set_random_word_to 'hello' }

    context 'successfully guessed the word' do
      it 'returns true' do

        'hello'.chars do |char|
          hangperson.guess(char)
        end

        expect(hangperson.win?).to be true
      end

      context 'no guess' do
        it 'returns false' do
          expect(hangperson.win?).to be false
        end
      end
    end
  end

  describe '#lose?' do
    context 'after 7 wrong guesses' do
      it 'returns true' do
        set_random_word_to 'hello'
        guess_several_letters(hangperson, 'sdgbnmk')
        expect(hangperson.lose?).to be true
      end
    end
  end
end

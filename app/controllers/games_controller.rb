require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alpha = [*('a'..'z')]
    vowel = ['a', 'e', 'i', 'o', 'u']
     @letters = alpha.sample(5) + vowel.sample(5)
  end

  def score
    @new = params[:new]
    @letters = params[:letters]
    if cont?
      if web?
        @score = "Congratulations! #{@new} is a valid English word!"
      else
        @score = "Sorry but #{@new} does not seem to be a valid English word."
      end
    else
      @score = "Sorry but #{@new} can't be built out of #{@letters}"
    end
  end

  def cont?
    @new.chars.sort.all? do |letter|
      @letters.include?(letter)
    end
  end

  def web?
    url = "https://wagon-dictionary.herokuapp.com/#{@new}"
    word_seri = open(url).read
    word = JSON.parse(word_seri)
    word["found"]
  end
end

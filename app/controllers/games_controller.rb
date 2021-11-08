require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    result_serialized = URI.open(url).read
    result = JSON.parse(result_serialized)

    if result["found"] == true
      @is_english_word = true
    else
      @is_english_word = false
    end


    if included?(params[:word].to_a, @grid)
      @in_grid = true
    else
      @in_grid = false
    end
  end
end

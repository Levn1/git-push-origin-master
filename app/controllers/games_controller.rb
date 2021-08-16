class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(26)).chr }
  end

  def score
    @score = 0
    @answer = params[:answer]
    @letters = params[:letters].split
    wordcheck = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@answer}").read)
    included = @answer.upcase.chars.all? { |letter| @answer.count(letter) <= @letters.count(letter) }

    if included == false
      @final = "Sorry, #{@answer} is NOT included in the letters."
    elsif wordcheck['found'] == false
      @final = "Sorry, #{@answer} is NOT an English word."
    elsif included && wordcheck['found']
      @final = 'Congratulations!'
    end

  end
end

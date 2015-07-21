class MoviesController < ApplicationController
  def index
    @questions = Question.all
    @flights = Flight.all
    @movies = Movie.all
  end

  def show
  end
end

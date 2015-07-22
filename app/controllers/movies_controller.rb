class MoviesController < ApplicationController
  def index
    @questions = Question.all
    @flights = Flight.all
    @movies = Movie.all
  end

  def show
    flight = Flight.find(route: params[:flight])
    time_remaining = flight.length
    @suggested_movies = Movie.all.calculate_list
    #need to decrement for each movie in suggested_movies so doesn't exceed
    #total flight time
  end
end

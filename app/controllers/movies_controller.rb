class MoviesController < ApplicationController
  def index
    @questions = Question.all
    @flights = Flight.all
    @movies = Movie.all
  end

  def show
    p params
    flight = Flight.where(route: params[:flight_name]).first
    time_remaining = flight.length
    @movie_scores = Hash.new(0)

    #adjust weight to each category
    category_multipliers = [2,2,1]
    Movie.all.each do |movie|
      genre_mapping = {
                      "Action" => "Befriend the Dinosaurs",
                      "Comedy" => "Laugh with John Belushi",
                      "Drama" => "Watch the tragic plays of Ancient Rome",
                      "Western" => "Live in the Wild West"
                      }
      #allocate genre points
      @movie_scores[movie.id] += category_multipliers[0] if genre_mapping[movie.genre] == params[:q1_radio]

      #allocate country of origin points
      @movie_scores[movie.id] += category_multipliers[1] if movie.country == params[:q2_radio]

      #allocate movie length
      if movie.length <= 4050 && params[:q3_radio] == 'short'
        @movie_scores[movie.id] += category_multipliers[2]
      elsif movie.length > 4050 && movie.length <= 6300 && params[:q3_radio] == 'average'
        @movie_scores[movie.id] += category_multipliers[2]
      elsif movie.length > 6300 && movie.length <= 8550 && params[:q3_radio] == 'long'
        @movie_scores[movie.id] += category_multipliers[2]
      elsif movie.length > 8550 && movie.length <= 10800 && params[:q3_radio] == 'titanic'
        @movie_scores[movie.id] += category_multipliers[2]
      end

    end
    @movie_scores = Hash[*(@movie_scores.sort_by{|k,v| v}.reverse).flatten]
    @sorted_movies = []
    @movie_scores.each do |k,v|
      @sorted_movies << Movie.all.find(k)
    end

    #need to decrement for each movie in suggested_movies so doesn't exceed
    #total flight time
    @final_movies = []
    @sorted_movies.each do |movie|
      next if time_remaining - movie.length < 0
      @final_movies << movie
      time_remaining -= movie.length
    end
    render json: {final_movies: @final_movies, flight: flight}.to_json
  end
end

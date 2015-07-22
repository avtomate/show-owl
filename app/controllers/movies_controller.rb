class MoviesController < ApplicationController
  def index
    @questions = Question.all
    @flights = Flight.all
    @movies = Movie.all
  end

  def show
    flight = Flight.all[6]  #Flight.where(route: params[:flight]).first
    time_remaining = flight.length

    @movie_scores = Hash.new(0)
    #adjust weight to each category
    category_multipliers = [4,2,1]
    Movie.all.each do |movie|
      #allocate genre points
      @movie_scores[movie.id] += category_multipliers[0] if movie.genre == "Action"#params[:genre]

      #allocate country of origin points
      @movie_scores[movie.id] += category_multipliers[1] if movie.country == "USA"#params[:country]

      #allocate movie length
      if movie.length <= 4050 #&& params[:length] == 'short'
        @movie_scores[movie.id] += category_multipliers[2]
      elsif movie.length > 4050 && movie.length <= 6300 #&& params[:length] == 'average'
        @movie_scores[movie.id] += category_multipliers[2]
      elsif movie.length > 6300 && movie.length <= 8550 #&& params[:length] == 'long'
        @movie_scores[movie.id] += category_multipliers[2]
      elsif movie.length > 8550 && movie.length <= 10800 #&& params[:length] == 'titanic'
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
      p "TIME AT BEGINNING OF ITERATION"
      p time_remaining
      p movie.length
      next if time_remaining - movie.length < 0
      @final_movies << movie
      time_remaining -= movie.length
      p "TIME AT END OF ITERATION"
      p time_remaining
    end
  end
end

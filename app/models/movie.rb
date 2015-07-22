class Movie < ActiveRecord::Base
  def calculate_list
    @movie_scores = Hash.new(0)
    #adjust weight to each category
    category_multipliers = [4,2,1]
    this.each.do |movie|
      #allocate genre points
      @movie_scores[movie.id] += category_multipliers[0] if movie.genre == params[:genre]

      #allocate country of origin points
      @movie_scores[movie.id] += category_multipliers[1] if movie.country == params[:country]

      #allocate movie length
      if movie.length <= 4050 && params[:length] == 'short'
        @movie_scores[movie.id] += category_multipliers[2]
      elsif movie.length > 4050 && movie.length <= 6300 && params[:length] == 'average'
        @movie_scores[movie.id] += category_multipliers[2]
      elsif movie.length > 6300 && movie.length <= 8550 && params[:length] == 'long'
        @movie_scores[movie.id] += category_multipliers[2]
      elsif movie.length > 8550 && movie.length <= 10800 && params[:length] == 'titanic'
        @movie_scores[movie.id] += category_multipliers[2]
      end

    end
    @movie_scores = @movie_scores.sort_by{|k,v| v}.reverse
    @movie_scores.each_key do |key|
      @sorted_movies << Movie.find(id: key)
    end
    @sorted_movies
  end
end

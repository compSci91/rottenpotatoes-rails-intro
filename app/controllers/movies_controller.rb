class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default

    puts "Inside show"
  end

  def index
    puts "Inside Index"
    @movies = Movie.all

    if (params[:ratings] != nil)
      session[:ratings] = params[:ratings]
      @movies = []
      params[:ratings].keys.each do |checked_rating|
        _foundMovies = Movie.where(rating: checked_rating)
        puts _foundMovies
        @movies.concat _foundMovies
        puts @movies
      end

    elsif(session[:ratings] != nil)
      @movies = []
      session[:ratings].keys.each do |checked_rating|
        _foundMovies = Movie.where(rating: checked_rating)
        puts _foundMovies
        @movies.concat _foundMovies
        puts @movies
      end

    end
    #default to using params, but assign the value to session
      if (params[:sort] == 'sort_by_name')
        @movies = @movies.sort_by {|movie| movie.title}
        session[:sort] = 'sort_by_name'
      elsif (params[:sort] == 'sort_by_release_date')
        @movies = @movies.sort_by {|movie| movie.release_date}
        session[:sort] = 'sort_by_release_date'
      elsif (params[:sort] == nil) #if no params are passed in, use what is in the session
        if (session[:sort] == 'sort_by_name')
          @movies = @movies.sort_by {|movie| movie.title}
        elsif (session[:sort] == 'sort_by_release_date')
          @movies = @movies.sort_by {|movie| movie.release_date}
          session[:sort] == 'sort_by_release_date'
        end
      end

      @all_ratings = Movie.getMovieRatings

      #redirect_to action: "new", :hash1 => "hash1", :hash2 => "hash2"


  end


  def new

    puts "Inside new"
    # default: render 'new' template
  end

  def create
    puts "Inside create"
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    puts "Inside edit"
    @movie = Movie.find params[:id]
  end

  def update
    puts "Inside update"
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    puts "Inside destroy"
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

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

      if (params[:sort] == 'sort_by_name')
        @movies = @movies.sort_by {|movie| movie.title}
      elsif (params[:sort] == 'sort_by_release_date')
        @movies = @movies.sort_by {|movie| movie.release_date}
      end
    #basket.sort_by { |f| [-f.calories, f.name] }
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

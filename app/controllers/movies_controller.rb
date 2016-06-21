class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      redirect_to 
    else
      render 'edit'
    end
  end

  def create
    @movie = Movie.new(movie_params)
   
    if @movie.save
      redirect_to movies_path, notice: "#{movie.title} was submitted successfully!"
    else
      render 'new' # save the already-typed info
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    
    redirect_to movies_path
  end

  private
    def movie_params
      params.require(:movie).permit(:title, :director, 
      :runtime_in_minutes, :description, :poster_image_url, :release_date)
    end
end

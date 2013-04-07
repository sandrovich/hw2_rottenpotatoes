class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.list_ratings
    @sortby = params[:sort]
    
    if params[:ratings] != nil
      @chk_ratings = params[:ratings].keys
    else
      @chk_ratings = @all_ratings
    end
    
    # if @chk_ratings == nil
    # if @sortby != nil
      # @movies = Movie.order(@sortby)
    # else
      # @movies = Movie.all
    # end
    # else
    
    @movies = Movie.find(:all, :conditions => { :rating => @chk_ratings }, :order => @sortby)
    
    # if chk_ratings != nil && @sortby != nil
      # @movies = Movie
    # elsif chk_ratings == nil && @sortby != nil
      # @movies = Movie.order(@sortby)
    # elsif @chk_ratings != nil && @sortby == nil
      # @movies = Movie.where(rating = ?, chk_ratings)
    # else
      # @movies = Movie.all
    # end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

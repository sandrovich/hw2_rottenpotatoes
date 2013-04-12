class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.list_ratings
    @chk_ratings = @all_ratings
    
    if !params[:ratings].nil?
      if !params[:ratings].nil?
        @chk_ratings = params[:ratings].keys
        session.delete(:ratings)
        session[:rating] = params[:ratings]
      end

      if !params[:sort].nil?
        @sortby = params[:sort]
        session.delete(:sort)
        session[:sort] = params[:sort]
      end
    elsif !session[:rating].nil? || !session[:sort].nil?
        params[:rating] = session[:rating]
        params[:sort] = session[:sort]
        session.clear
        redirect_to movies_path(:ratings => params[:rating], :sort => params[:sort])

    end
    
    @movies = Movie.find(:all, :conditions => { :rating => @chk_ratings }, :order => @sortby)
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

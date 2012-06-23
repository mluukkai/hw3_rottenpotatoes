class ReviewsController < ApplicationController
  def create
    #debugger
    value = params[:review][:potatoes]
    review = Review.new(:potatoes => value)
    movie = Movie.find(params[:movie_id])
    user = current_user

    if user and movie
      movie.reviews << review
      user.reviews << review
      movie.save!
      user.save!
      flash[:notice] = "review #{value} given"
    else
      flash[:error] = "review not given"
    end

    redirect_to movie_path(params[:movie_id])
  end
end
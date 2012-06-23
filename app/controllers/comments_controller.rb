class CommentsController < ApplicationController
  def create
    value = params[:comments]
    comment = Comment.new(:comments => value)
    movie = Movie.find(params[:movie_id])
    user = current_user

    if user and movie
      movie.comments << comment
      user.comments << comment
      movie.save!
      user.save!
      flash[:notice] = "comment given"
    else
      flash[:error] = "comment not given"
    end

    redirect_to movie_path(params[:movie_id])
  end
end
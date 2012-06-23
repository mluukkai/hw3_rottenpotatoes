class WithsamedirectorController < ApplicationController
  def show
    #debugger
    @director = Movie.director_for(params[:id])
    if @director
      @movies = Movie.find_all_by_director(@director)
    else
      flash[:notice] = "'#{Movie.find(params[:id]).title}' has no director info"
      redirect_to :controller => "movies", :action => "index"
    end
  end

  def create
    auth = request.env["omniauth.auth"]
    user = Moviegoer.find_by_provider_and_uid(auth["provider"], auth["uid"]) ||
      Moviegoer.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to movies_path
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to movies_path
  end
end
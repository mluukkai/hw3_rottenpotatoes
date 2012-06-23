class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def anon
    user = User.find_by_name("anonymous")
    if not user
      user = User.new :name => "anonymous"
      user.save!
    end

    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def signin; end

  def signin_post
    #debugger
    user = User.find_by_name(params[:name])
    #debugger
    if not user or user.provider != "potatoes"
      flash[:notice] = "user '#{params[:name]}' does not exist"
      redirect_to signin_path
    else
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Signed in!"
    end
  end

  def register;end

  def register_post
    name = params[:name]
    user = User.find_by_name(name)
    if user
      flash[:notice] = "user '#{name}' exist already"
      redirect_to register_path
    elsif params[:password] != params[:password_conf]
    flash[:notice] = "passwords do not match"
    redirect_to register_path
    else
      User.create!  :name => name, :provider => "potatoes"
      redirect_to "/movies", :notice => "New user #{name} created!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end

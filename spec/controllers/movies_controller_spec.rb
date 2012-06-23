require 'spec_helper'

describe MoviesController do
  fixtures :movies

  before :each do
    #Movie.create! :title => "foobar"
    @id = Movie.all[0].id
  end

  it "should show details of one movie" do
    puts "*********"
    puts @id
    puts Movie.all.inspect
    puts "*********"
    get :show, {:id => @id}
  end

  it "should open edit view" do
    get :edit, {:id => @id}
  end

  it "should change details of one movie" do
    post :update, {:id => @id}
  end

  it "should destroy the whole shit" do
     post :destroy, {:id => @id}
   end

  it "should open create page" do
    get :new
  end

  it "should create new movie" do
    post :create, {:title => "foobar"}
  end

  it "should list movies" do
    get :index
  end

  it "should list movies sorted by title" do
    get :index, {:sort => "release_date"}
  end

  it "should list movies sorted by title" do
    get :index, {:sort => "title"}
  end

end
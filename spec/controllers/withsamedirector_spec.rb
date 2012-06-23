require 'spec_helper'

describe WithsamedirectorController do
  fixtures :movies

  before :each do
    #Movie.create! :title => "foobar"
    @id = Movie.all[0].id
  end

  it 'should call the model method to find movies with same directors' do
    Movie.should_receive(:director_for).with("1").and_return("kubric")
    get :show, {:id => @id}
  end

  it 'should render the right template' do
    get :show, {:id => @id}
    response.should render_template('show')
  end

  it 'should give correct set of movies to view' do
    fake_results = [mock('movie1'), mock('movie2')]
    Movie.stub(:director_for).and_return("kubric")
    Movie.stub(:find_all_by_director).and_return(fake_results)

    get :show, {:id => @id}
    assigns(:movies).should == fake_results
  end

  it 'should handle the case with no director' do
    fake_results = [mock('movie1'), mock('movie2')]
    Movie.stub(:director_for).and_return(nil)
    Movie.stub(:find_all_by_director).and_return(fake_results)

    get :show, {:id => @id}
    response.should redirect_to(:controller => "movies", :action => "index")
  end

end
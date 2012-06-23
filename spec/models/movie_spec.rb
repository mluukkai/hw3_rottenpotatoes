require 'spec_helper'

describe Movie do
  fixtures :movies

  it 'should be possible to get list of ratings' do
    Movie.all_ratings.length.should be > 0
  end

  it 'should include rating and year in full name' do
    movie = movies(:milk_movie)
    movie.name_with_rating.should == 'Milk (R)'
  end

  it 'should give name of director' do
    id = movies(:milk_movie).id
    Movie.director_for(id).should == 'Gandhi'
  end

  it 'should give nil if director empty' do
    id = movies(:bad_movie).id
    Movie.director_for(id).nil?.should == true
  end

  it 'should give nil if no director' do
    id = movies(:worse_movie).id
    Movie.director_for(id).nil?.should == true
  end
end
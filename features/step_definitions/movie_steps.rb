# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  regexp = /#{e1}.*#{e2}/m
  page.body.should =~ regexp
end


When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(",").each{ |r|
    step "I #{uncheck}check \"ratings[#{r.strip}]\""
  }
end

Then /^I should (not )?see all of the movies:$/ do |nt, table|
  table.hashes.each{ |m|
    step "I should #{nt }see \"#{m[:title]}\""
  }
end

Then /^I should see movies in following order:$/ do |table|
  r = ""
  table.hashes.each do |movie|
    r += movie[:title] + ".*"
  end
  regexp = /#{r}/m
  page.body.should =~ regexp
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  Movie.find_by_title(arg1).director.should == arg2
end

Then /^I should see "([^"]*)" has no director info$/ do |movie|
  Movie.all_ratings.each { |r|
    step "I check \"ratings[#{r}]\""
  }
  step 'I press "ratings_submit"'

  page.body.split("<tr>").each { |row|
    name_author = movie_name_and_author(row)
    if name_author
      name_author[1].blank?.should == true if name_author[0] == movie
    end
  }

end

def movie_name_and_author(row)
  regex = /^<td>(.*)<\/td>.*$/

  parts = row.split("\n")

  parts[1] =~ regex
  movie = $1
  return nil if not movie

  parts[4] =~ regex
  director = $1
  return nil if not director

  return [movie, director]
end

When /^info$/ do
  puts "*********************"
  Movie.all.each { |m|
    puts m.inspect
  }
  m = Movie.find(7)
  puts m.director == nil
  puts "*********************"
end


#Then /^I should see all of the movies:$/ do |table|
#  table.hashes.each{ |m|
#    step "I should see \"#{m[:title]}\""
#  }
#end
#
#Then /^I should not see all of the movies:$/ do |table|
#  table.hashes.each{ |m|
#    step "I should not see \"#{m[:title]}\""
#  }
#end
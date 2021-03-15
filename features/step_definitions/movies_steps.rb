# Add a declarative step here for populating the DB with movies.
Before do
  DatabaseCleaner.start
end

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie) #Needs Testing
  end
  #fail "Unimplemented"
end

#From HW3 - again!!
Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2)).to be true
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(",").each do |rating|
    steps %{
      When I #{uncheck}check "#{rating}"
    }
  end
  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  # Movie.all() do |row|
  #   title = row[:title]
  #   step "I should see \"#{title}\""
  # end
  expect(page.find_by_id("movies").find('tbody').all('tr').size).to eq Movie.count
end

Then /the director of "(.*)" should be "(.*)"/ do |title, expected_value|
  expect(Movie.find_by(:title => title).director).to eq expected_value
end

After do
  DatabaseCleaner.clean
  #fail "Unimplemented"
end
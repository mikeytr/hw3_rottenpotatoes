# Add a declarative step here for populating the DB with movies.

Given /the following movies exist:$/ do |movies_table|
  movies_table.hashes.each do |movie|
      title = movie[:title]
      rating = movie[:rating]
      release_date = movie[:release_date]
      Movie.create!(:title => title, :rating => rating, :release_date => release_date)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
   regexp = /#{e1}.*#{e2}/m
   page.body.should =~ regexp
end

Then /I should see (.*) movies/ do |number|
   rows = page.all('table#movies tbody tr').count
   rows.should == Integer(number)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratiUnimplemented (MiniTest::Assertion)ngs: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
   rating_list.split(/,[\s+]/).each do |rating|
      case uncheck
         when "un"
            uncheck("ratings_#{rating}")
         else
            check("ratings_#{rating}")
      end
   end
end

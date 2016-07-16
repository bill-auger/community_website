def path_to page_name
  case page_name

  when /^Home$/      then '/'
  when /^Projects$/  then '/projects'
  when /^Users$/     then '/users'
  when /^Badges$/    then '/badges'
  when /^Emoticons$/ then '/emoticons'

  else
    '/unknown-path'
  end
end


Given /^I am on the "([^"]*)" page$/ do | page_name |
  visit path_to page_name
  step 'I should be on the "' + page_name + '" page'
end

Then /^I should see the "([^"]*)" button in the top navbar$/ do | text |
  within(:css , 'div#top-nav-div') do
    page.body.should have_content text
  end
end

Then /^I should see the Logo button in the top navbar$/ do
  within(:css , 'div#top-nav-div') do
    page.should have_css 'a#top-nav-logo-a img'
  end
end

When /^I click the "([^"]*)" button in the top navbar$/ do | text |
  within(:css , 'div#top-nav-div') do
    (find_link text).click
  end
end

When /^I click the Logo button in the top navbar$/ do
  (find 'a#top-nav-logo-a').click
end

Then /^I should be on the "([^"]*)" page$/ do | page_name |
  page.current_path.should eq path_to page_name
end

Then /^I should be on the LCTV page$/ do
  page.current_url.should eq LCTV_URL
end

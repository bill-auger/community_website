
def sign_out
#   page.driver.submit :delete , signout_path , {} # DELETE
  visit signout_path
end

def sign_in
#   Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:default] # GET
#   visit '/auth/developer/callback' # GET
  visit '/auth/developer'
  fill_in 'name' , :with => 'a-nick'
  (find_button "Sign In").click
end

def path_to page_name
  case page_name

  when /^Home$/          then '/'
  when /^Projects$/      then '/projects'
  when /^Users$/         then '/users'
  when /^Badges$/        then '/badges'
  when /^Emoticons$/     then '/emoticons'
  when /^LCTV$/          then '/emoticons'
  when /^LCTV API auth$/ then '/emoticons'

  else
    '/unknown-path'
  end
end


Given /^I am( not)* signed in$/ do | is_not |
  should_sign_in = is_not.blank?

  should_sign_in ? sign_in : sign_out
  step 'I should' + (should_sign_in ? ' not' : '') + ' see "LOGIN"'
end

Given /^I am on the "([^"]*)" page$/ do | page_name |
  visit path_to page_name
  step 'I should be on the "' + page_name + '" page'
end

Then /^I should be on the "([^"]*)" page$/ do | page_name |
  case page_name
  when 'LCTV' ; page.current_url .should eq LCTV_URL          ;
  else        ; page.current_path.should eq path_to page_name ;
  end
end

Then /^I should( not)* see the "([^"]*)" button in the top navbar$/ do | is_not , text |
  test = is_not.blank? ? :should : :should_not

  case text
  when 'Logo'   ; page     .send test , (have_css     'a#top-nav-logo-a img') ;
  when 'Avatar' ; page     .send test , (have_css     'a#top-nav-user-a img') ;
  else          ; page.body.send test , (have_content text                  ) ;
  end
end

Then(/^I should( not)* see "([^"]*)"$/) do | is_not , text |
  test = is_not.blank? ? :should : :should_not

  page.body.send test , (have_content text)
end

When /^I click the "([^"]*)" button in the top navbar$/ do | text |
  within :css , 'div#top-nav-div' do
    case text
    when 'Logo'   ; (find      'a#top-nav-logo-a').click ;
    when 'Avatar' ; (find      'a#top-nav-user-a').click ;
    else          ; (find_link text              ).click ;
    end
  end
end

When(/^I click "([^"]*)"$/) { | text | ; (find_link text).click }

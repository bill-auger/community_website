
def sign_out
#   page.driver.submit :delete , signout_path , {} # DELETE
  visit signout_path
end

def sign_in nick
#   Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:default] # GET
#   visit '/auth/developer/callback' # GET
  visit url_to 'Login'
  fill_in 'name' , :with => nick
  (find_button "Sign In").click
end

def url_to page_name
  case page_name
  when /^Home$/          then '/'
  when /^Projects$/      then '/projects'
  when /^Users$/         then '/users'
  when /^Forum$/         then '/forum'
  when /^Polls$/         then '/polls'
  when /^Badges$/        then '/badges'
  when /^Emoticons$/     then '/emoticons'
  when /^Login$/         then '/auth/developer'
  when /^LCTV$/          then LCTV_URL
  when /^LCTV API$/      then LCTV_API_URL
  else                        '/unknown-page'
  end
end

def new_or_index_path_for model , action
  case model.downcase
  when 'poll'
    new_poll_path
  else 'unknown-page'
  end
end

def show_or_edit_path_for model , action , page_name
  case model.downcase
  when 'poll'
    case action.downcase
    when 'show'
      poll_path      (Poll.find_by_topic page_name)
    when 'edit'
      edit_poll_path (Poll.find_by_topic page_name)
    end
  else 'unknown-page'
  end
end


Given /^I am( not)* signed in$/ do | is_not |
  should_sign_in = is_not.blank?

  should_sign_in ? (sign_in 'mock-nick') : sign_out
end

Given /^I should( not)* be signed in$/ do | is_not |
  should_be_signed_in = is_not.blank?

  step 'I should' + (should_be_signed_in ? ' not' : '') + ' see "LOGIN"'
end

Given (/^I sign in$/) { step 'I am signed in' }

Given (/^I sign out$/) { step 'I am not signed in' }

Given (/^I am signed in as "([^"]*)"$/) { | nick | ; sign_in nick }

Given /^I am on the "([^"]*)" page$/ do | page_name |
  visit url_to page_name
  step 'I should be on the "' + page_name + '" page'
end

Then /^I am on the "([^"]*)" "([^"]*)" "([^"]*)" page$/ do | page_name , action , model |
  visit show_or_edit_path_for model , action , page_name
  step 'I should be on the "' + page_name + '" "' + action + '" "' + model + '" page'
end

Then /^I should be on the "([^"]*)" page$/ do | page_name |
  case page_name
  when 'LCTV'     ; page.current_url .should eq url_to page_name ;
  when 'LCTV-API' ; page.current_url .should eq url_to page_name ;
  else            ; page.current_path.should eq url_to page_name ;
  end
end

Then /^I should be on the "([^"]*)" "([^"]*)" page$/ do | action , model |
  page.current_path.should eq new_or_index_path_for model , action
end

Then /^I should be on the "([^"]*)" "([^"]*)" "([^"]*)" page$/ do | page_name , action , model |
  page.current_path.should eq show_or_edit_path_for model , action , page_name
end

Then /^I should( not)* see the "([^"]*)" button in the top navbar$/ do | is_not , text |
  test = is_not.blank? ? :should : :should_not

  case text
  when 'Logo'   ; page     .send test , (have_css     'a#top-nav-logo-a img') ;
  when 'Avatar' ; page     .send test , (have_css     'a#top-nav-user-a img') ;
  else          ; page.body.send test , (have_content text                  ) ;
  end
end

Then /^I should( not)* see "([^"]*)"$/ do | is_not , text |
  test = is_not.blank? ? :should : :should_not

  page.body.send test , (have_content text)
end

Then /^I should( not)* see an* "([^"]*)" button$/ do | is_not , text |
  test = is_not.blank? ? :should : :should_not

  page.body.send test , (have_button text)
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

When (/^I click "([^"]*)"$/) { | text | ; (find_link text).click }

When (/^I press "([^"]*)"$/) { | text | ; (click_button text) }

When /^I fill "([^"]*)" with "([^"]*)"$/ do | field , text |
  fill_in field , :with => text
end

Then(/^"([^"]*)" should( not)* be chosen$/) do | option_text , is_not |
  test  = is_not.blank? ? :should : :should_not
  radio = find_field option_text

  radio.send test , be_checked
end

When /^I choose "([^"]*)"$/ do | option_text |
  choose option_text
end


Given /^the following Polls exist:$/ do | polls_table |
  user = User.find_or_create_with_omniauth OmniAuth.config.mock_auth[:default]

  polls_table.hashes.each do | poll_params |
    topic        = poll_params[:topic  ]
    is_open      = poll_params[:is_open]
    poll_options = poll_params[:options].to_s.split ','

    poll = user.polls.create! do | new_poll |
      new_poll.topic   = topic
      new_poll.is_open = is_open
    end
    poll_options.each do | an_option_text |
      poll.poll_options.create! do | new_poll_option |
        new_poll_option.option = an_option_text.gsub "'" , ''
      end
    end
  end
end

Then /^the poll should be open for voting$/ do
  (find 'input#poll_is_open').should be_checked
end

When /^I fill option "([^"]*)" with "([^"]*)"$/ do | option_n , text |
  option_n = option_n.to_i - 1
  wrapper  = (find_all 'div.nested-fields')[option_n]
  field    = wrapper.find 'input'

  fill_in field[:id] , :with => text
end

When /^I click Remove Option "([^"]*)"$/ do | option_n |

  sleep 2
  option_n = option_n.to_i - 1
  wrapper  = (find_all 'div.nested-fields')[option_n]

  (wrapper.find_link 'Remove Option').click
end

Then /^I should see Remove Option "([^"]*)" times*$/ do | n_options |
  sleep 2
  (find_all 'div.nested-fields').size.should be n_options.to_i
end


After do | scenario |
  Cucumber.wants_to_quit = scenario.failed?
end

Before('@omniauth_test') do
  OmniAuth.config.test_mode = true
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end

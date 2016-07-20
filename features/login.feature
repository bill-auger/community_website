Feature: Global Site Login
  As a visitor to the site
  So that I can access authenticated features
  I want to be able to login and logout


  Background:
    Given I am on the "Home" page

  Scenario: Login and signup buttons are accessible when signed out
    Given I am not signed in
    Then  I should see the "LOGIN" button in the top navbar
    And   I should see the "SIGN UP" button in the top navbar
    But   I should not see the "Avatar" button in the top navbar

  Scenario: Logout button is not accessible when signed in
    Given I am signed in
    Then  I should not see the "LOGIN" button in the top navbar
    And   I should not see the "SIGN UP" button in the top navbar
    But   I should see the "Avatar" button in the top navbar

  Scenario: I log in to the site
    Given I am not signed in
    When  I click "LOGIN"
    Then  I should be on the "Login" page
    When  I fill "name" with "my-nick"
    And   I press "Sign In"
    Then  I should see "Signed in"
    And   I should be signed in

  Scenario: I log out of the site
    Given I am signed in
    When  I click the "Avatar" button in the top navbar
    Then  I should see "Signed out"
    And   I should see the "LOGIN" button in the top navbar
    And   I should see the "SIGN UP" button in the top navbar
    But   I should not see the "Avatar" button in the top navbar
    And   I should not be signed in

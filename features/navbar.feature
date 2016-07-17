Feature: Global Site Navigation
  As a visitor to the site
  So that I can have quick access to the main sections
  I want to have several links or buttons easily accessible


  Background:
    Given I am on the "Home" page
    Then  I should see the "Logo" button in the top navbar
    Then  I should see the "Home" button in the top navbar
    Then  I should see the "Projects" button in the top navbar
    Then  I should see the "Users" button in the top navbar
    Then  I should see the "Badges" button in the top navbar
    Then  I should see the "Emoticons" button in the top navbar

  Scenario: Navigate to LCTV page
    When I click the "Logo" button in the top navbar
    Then I should be on the "LCTV" page

  Scenario: Navigate to Home page
    When I click the "Home" button in the top navbar
    Then I should be on the "Home" page

  Scenario: Navigate to Projects page
    When I click the "Projects" button in the top navbar
    Then I should be on the "Projects" page

  Scenario: Navigate to Users page
    When I click the "Users" button in the top navbar
    Then I should be on the "Users" page

  Scenario: Navigate to Badges page
    When I click the "Badges" button in the top navbar
    Then I should be on the "Badges" page

  Scenario: Navigate to Emoticons page
    When I click the "Emoticons" button in the top navbar
    Then I should be on the "Emoticons" page

Feature: Vote in Polls
  As a visitor to the site
  So that project managers can learn my opinions
  I want to vote on all of the available polls


  Background:
    Given the following Polls exist:
    | topic  | is_open | options                          |
    | Poll 1 | true    |                                  |
    | Poll 2 | false   |                                  |
    | Poll 3 | true    | 'Option 1','Option 2','Option 3' |


  Scenario: View available Polls
    Given I am on the "Polls" page
    Then  I should see "Poll 1"
    And   I should see "Poll 3"
    But   I should not see "Poll 2"

  Scenario: Navigate to a Poll page
    Given I am on the "Polls" page
    When  I click "Poll 1"
    Then  I should be on the "Poll 1" "show" "poll" page
    And   I should see "Poll 1"
    But   I should not see "Poll 2"
    And   I should not see "Poll 3"

  Scenario: Must be logged in to vote on a Poll
    Given I am not signed in
    And   I am on the "Poll 1" "show" "poll" page
    Then  I should not see a "Vote" button

  Scenario: Can not vote on a Poll with no options
    Given I am signed in
    And   I am on the "Poll 1" "show" "poll" page
    Then  I should not see a "Vote" button

  @javascript
  Scenario: Can not vote until an option is selected
    Given I am signed in
    And   I am on the "Poll 3" "show" "poll" page
    Then  "Option 1" should not be chosen
    And   "Option 2" should not be chosen
    And   "Option 3" should not be chosen
    And   I should not see a "Vote" button
    When  I choose "Option 1"
    Then  I should see a "Vote" button

  @javascript
  Scenario: Vote on a Poll
    Given I am signed in
    And   I am on the "Poll 3" "show" "poll" page
    When  I choose "Option 2"
    And   I press "Vote"
    Then  I should be on the "Poll 3" "show" "poll" page
    And   "Option 1" should not be chosen
    But   "Option 2" should be chosen
    And   "Option 3" should not be chosen
    When  I am on the "Home" page
    And   I am on the "Poll 3" "show" "poll" page
    Then  "Option 1" should not be chosen
    But   "Option 2" should be chosen
    And   "Option 3" should not be chosen

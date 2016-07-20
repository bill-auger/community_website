Feature: Create Polls
  As a project maintainer
  So that I can learn about users's opinions
  I want to create polls with any number of options


  Background:
    Given the following Polls exist:
    | topic  | is_open |
    | Poll 1 | true    |


  Scenario: Must be logged in to create a new Poll
    Given I am not signed in
    When  I am on the "Polls" page
    Then  I should see "New Poll"
    When  I click "New Poll"
    Then  I should be on the "Login" page

  Scenario: Create a new Poll
    Given I am signed in
    When  I am on the "Polls" page
    Then  I should see "New Poll"
    When  I click "New Poll"
    Then  I should be on the "new" "poll" page
    And   I should see "Topic:"
    And   I should see a "Create Poll" button
    When  I fill "Topic" with "Important Question"
    And   I press "Create Poll"
    Then  I should be on the "Important Question" "edit" "poll" page
    And   I should see "Important Question"
    And   I should see "Is open?:"
    And   the poll should be open for voting
    And   I should see "Poll Options:"
    And   I should see "Add Option"
    And   I should see an "Update Poll" button

  Scenario: Must be logged in to edit an existing Poll
    Given I am not signed in
    When  I am on the "Poll 1" "show" "poll" page
    Then  I should see "Topic:"
    And   I should see "Poll 1"
    And   I should see "Maintainer: mock-nick"
    And   I should not see "Is open?: true"
    And   I should not see "Poll Options:"
    But   I should not see "Edit"

  Scenario: Only the poll owner may edit an existing Poll
    Given I am signed in as "someone-else"
    When  I am on the "Poll 1" "show" "poll" page
    Then  I should see "Topic:"
    And   I should see "Poll 1"
    And   I should see "Maintainer: mock-nick"
    And   I should not see "Is open?: true"
    And   I should not see "Poll Options:"
    But   I should not see "Edit"

  @javascript
  Scenario: Add and remove options to/from existing Poll
    Given I am signed in
    And   I am on the "Poll 1" "show" "poll" page
    Then  I should see "Topic:"
    And   I should see "Poll 1"
    And   I should see "Maintainer: mock-nick"
    And   I should see "Is open?: true"
    And   I should not see "Poll Options:"
    And   I should see "Edit"
    When  I click "Edit"
    Then  I should be on the "Poll 1" "edit" "poll" page
    And   I should see "Topic:"
    And   I should see "Poll 1"
    And   I should see "Is open?:"
    And   the poll should be open for voting
    And   I should see "Poll Options:"
    And   I should see "Add Option"
    And   I should see an "Update Poll" button
    But   I should not see "Remove Option"
    When  I click "Add Option"
    Then  I should see Remove Option "1" times
    When  I fill option "1" with "An Option"
    And   I press "Update Poll"
    Then  I should be on the "Poll 1" "show" "poll" page
    And   I should see "An Option"
    When  I click "Edit"
    Then  I should be on the "Poll 1" "edit" "poll" page
    When  I click "Add Option"
    Then  I should see Remove Option "2" times
    When  I fill option "2" with "Another Option"
    And   I press "Update Poll"
    Then  I should be on the "Poll 1" "show" "poll" page
    And   I should see "An Option"
    And   I should see "Another Option"
    When  I click "Edit"
    Then  I should be on the "Poll 1" "edit" "poll" page
    When  I click "Add Option"
    Then  I should see Remove Option "3" times
    When  I fill option "3" with "A Third Option"
    And   I press "Update Poll"
    Then  I should be on the "Poll 1" "show" "poll" page
    And   I should see "An Option"
    And   I should see "Another Option"
    And   I should see "A Third Option"
    When  I click "Edit"
    Then  I should be on the "Poll 1" "edit" "poll" page
    When  I click Remove Option "2"
    And   I press "Update Poll"
    Then  I should be on the "Poll 1" "show" "poll" page
    And   I should see "An Option"
    And   I should see "A Third Option"
    But   I should not see "Another Option"

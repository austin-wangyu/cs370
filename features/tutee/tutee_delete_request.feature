@javascript
Feature: Create tutoring request
  As a Tutee
  I want to delete my request
  When I don't need tutoring

  Background: There exists a tutee with a pending request in CS61B
    Given I log in with email "tt1@berkeley.edu" and password "111111"
    Then I should see "Status: Request submitted"
    And I should see button "Delete Request"

  Scenario: Tutee deletes request and it does not appear for tutors
    When I click on "Previous Requests" link
    Then I should see "seeded request tutee 1 - 3"
    And I should see "open"

    When I click on "Current Request" link
    And I press "Delete Request"
    Then I should see "Request deleted."
    And I should see "Status: No request pending."

    When I click on "Previous Requests" link
    Then I should not see "seeded request tutee 1 - 3"

    When I press "Log Out"
    And I log in with email "tr1@berkeley.edu" and password "111111"
    And I click on "Find Tutees" link
    And I click on "CS61B" link
    Then I should see "There are no requests for CS61B at this time."

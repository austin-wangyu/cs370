@javascript
Feature:
  As an admin
  So that I can control which tutees can request more than an hour of tutoring
  I want to be able to designate a list of tutees with priority

  Background: I am on the Manage Semester admin page
    And I log in as admin
    Then I should be on the admin home page
    When I press link "Manage Semester"
    Then I should be on the manage semester page
    And I should see "Set Tutee Priority"

  Scenario: Give tutee priority status
    When I update the priority list to "tr1@berkeley.edu, tt2@berkeley.edu"
    And I press "Update Tutee Priorities"
    Then I should see "Tutor One"
    And I should see "Tutee Two"
    And I should see "Tutee Three"

  Scenario: Remove tutee priority status
    Then I should see "Tutee Three"
    And I should see "tt3@berkeley.edu"
    When I press "Remove Priority"
    Then I should see "Priority successfully removed for Tutee Three"
    And I should not see "tt3@berkeley.edu"

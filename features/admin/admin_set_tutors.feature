@javascript
Feature:
  As an admin
  So that I can control which users can tutor others
  I want to be able to designate who is and is not a tutor

  Background: I am on the Manage Semester admin page
    And I log in as admin
    Then I should be on the admin home page
    When I press link "Manage Tutors"
    Then I should be on the manage tutors page
    And I should see "Set Tutors"

  Scenario: Set Tutor type
    When I should not see "Tutee One"
    And I should not see "Tutee Two"
    And I should not see "Tutee Three"
    When I update the tutor list to "tt1@berkeley.edu, tt2@berkeley.edu"
    And I press "Update Tutor List"
    And I should see "Tutee One"
    And I should see "Tutee Two"
    And I should not see "Tutee Three"

  Scenario: Remove Tutor type
    Then I should see "Tutor One"
    And I should see "tr1@berkeley.edu"
    When I press the first "Remove Tutor"
    Then I should see "Tutor status removed for Tutor One"
    And I should not see "tr1@berkeley.edu"

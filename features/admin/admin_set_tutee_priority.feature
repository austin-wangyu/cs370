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

  Scenario: A new user who has been pre-approved signs up
    When I update the priority list to "new_user@berkeley.edu"
    And I press "Update Tutee Priorities"
    Then I should see "new_user@berkeley.edu"
    And I should not see "New User"

    When I press link "Log Out"
    And I am on the home page
    When I press link "Sign up"

    And I fill in "First Name" with "New"
    And I fill in "Last Name" with "User"
    And I fill in "Email" with "new_user@berkeley.edu"
    And I fill in "Password" with "topsecret"
    And I fill in "Password Confirmation" with "topsecret"
    And I bootstrap select "Male" from "Gender"
    And I bootstrap select "He/His" from "Pronouns"
    And I bootstrap select "Korean" from "Ethnicity"
    And I bootstrap select "9 or higher" from "Current Term in Attendance"
    And I bootstrap select "Intended" from "Major"
    And I bootstrap select "Other" from "Major"
    And I bootstrap select "Yes" from "DSP Student?"
    And I bootstrap select "Yes" from "Transfer Student?"
    And I press "Create Account"
    Then I should see "Account was successfully created. Please check your email to authenticate your account"

    When I log in as admin
    And I press link "Manage Semester"
    #Full name of User associated with new_user@berkeley.edu appears in the table.
    Then I should see "New User"

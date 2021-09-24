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

  Scenario: A new user who has been pre-approved signs up
    When I update the tutor list to "new_user@berkeley.edu"
    And I press "Update Tutor List"
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
    When I press link "Manage Tutors"
    #Full name of User associated with new_user@berkeley.edu appears in the table.
    Then I should see "New User"

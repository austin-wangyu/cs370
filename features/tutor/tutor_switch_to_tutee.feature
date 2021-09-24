@javascript
Feature: Tutor can confirm a meeting with student

  As a current tutor
  I want to switch to the tutee view
  So that I can make my own requests to receive tutoring

  Background: Tutor switch to tutee button exists
    Given I log in with email "tr1@berkeley.edu" and password "111111"
    Then I should see button "Switch to Tutee View"

  Scenario: Making a Request and Completing the Pipeline as a Tutor
    When I press "Switch to Tutee View"
    Then I should see "Status: No request pending."
    And I should see button "Switch to Tutor View"

    When I click on "Previous Requests" link
    Then I should see "You have no previous requests"

    When I click on "Current Request" link
    And I select "CS10" from "request_course"
    And I fill in "request_subject" with "Something about scratch I think"
    And I press "Make Request"
    Then I should see "Tutoring request for class CS10 was successfully created!"
    And I should see "Status: Request submitted"

    When I click on "Previous Requests" link
    Then I should see "open"
    And I should not see "You have no previous requests"

    When I press "Log Out"
    And I log in with email "tr2@berkeley.edu" and password "111111"
    And I click on "Find Tutees" link
    And I click on "CS10" link
    Then I should see "Tutor One"
    And I should see "Something about scratch I think"

    When I click on the element with id "row_0"
    Then I should see "Send Invitation"
    When I press "Send Invite"
    Then I should see "Successfully matched!"

    When I click on the element with id "row_1"
    And I fill date "meeting_date" with "12/04/12"
    And I fill time "meeting_time" with "08:30AM"
    And I fill in "meeting_location" with "Moffitt"
    And I press "Confirm Meeting"
    Then I should see "Successfully confirmed meeting details!"

    When I click on the element with id "row_1"
    And I press "Finish Meeting"
    And I confirm popup
    Then I should see "Your meeting was successfully finished."

    When I press "Log Out"
    And I log in with email "tr1@berkeley.edu" and password "111111"
    And I press "Switch to Tutee View"
    Then I should see "Status: Evaluation pending. You must complete the evaluation before making another request."

    When I fill in "response_1" with "This is a very long text box whose idea was it to make it a minimum of 50 characters I mean really"
    And I fill in "response_2" with "Well they did some stuff okay but honestly giving me food was the best part"
    And I fill in "response_3" with "They should probably not be gone for half the meeting getting food though"
    And I press "Submit Evaluation"
    Then I should see "Evaluation submitted!"
    And I should see "No request pending"

    When I click on "Previous Requests" link
    Then I should see "complete"

  Scenario: Tutor cannot tutor themselves
    When I press "Switch to Tutee View"
    Then I should see "Status: No request pending."
    And I should see button "Switch to Tutor View"

    When I click on "Previous Requests" link
    Then I should see "You have no previous requests"

    When I click on "Current Request" link
    And I select "CS10" from "request_course"
    And I fill in "request_subject" with "Something about scratch I think"
    And I press "Make Request"
    Then I should see "Tutoring request for class CS10 was successfully created!"
    And I should see "Status: Request submitted"

    When I press "Switch to Tutor View"
    And I click on "Find Tutees" link
    And I click on "CS10" link

    Then I should see "Tutor One"
    And I should see "You cannot tutor yourself"

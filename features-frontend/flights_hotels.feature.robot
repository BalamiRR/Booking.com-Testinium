*** Settings ***
Resource    ../step-definition/frontend/flights_hotels.steps.robot
Force Tags    UC-FLIGHTS-HOTELS
Suite Setup    Open BookingApp
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot
Suite Teardown    Close All Browsers

*** Test Cases ***
Scenario: Searching for the departure field
    [Documentation]
     ...    Verify the functionality of the departure input field on the Flights and Hotel page.
     ...    Ensures that users can click on the departure field and see it ready for input.
     ...    enter at least one letter, relevant city or airport suggestions appear.
    [Tags]    High
    Given I will be redirected to the Flight and Hotel page
    And I select the english language on the top
    When I click on the departure field
    Then I see that the departure field is active
    And I see that the field is ready for input
    When I enter at least one letter "O"
    Then I see related cities or airports as suggestions

Scenario: Assign a new departure to a departure field
    [Documentation]
     ...    Select a departure randomly from the item proposed in the list
     ...    Ensure that the new departure is assigned to the departure field 
    [Tags]    Medium
    Given I select a random departure from the list
    Then The departure will be assigned to the departure field

Scenario: Searching for the destination field
    [Documentation]
     ...    Verify the functionality of the destination input field on the Flights and Hotel page.
     ...    Ensures that users can click on the destination field and see it ready for input.
     ...    enter at least one letter, relevant city or airport suggestions appear.
    [Tags]    High
    When I click on the destination field
    Then I see that the destination field is active
    And I see that the destination field is ready for input
    When I enter a letter "I"
    Then I see related cities or airports for destination



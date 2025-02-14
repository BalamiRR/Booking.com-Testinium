*** Settings ***
Resource    ../step-definition/frontend/flights_hotels.steps.robot
Force Tags    UC-FLIGHTS-HOTELS
Suite Setup    Open BookingApp
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot
Suite Teardown    Close All Browsers

*** Keywords ***
    

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
    When I enter a letter "I"
    Then I see related cities or airports for destination

Scenario: Assign a new destination to a destination field
    [Documentation]
     ...    Select a destination randomly from the item proposed in the list
     ...    Ensure that the new destination is assigned to the destination field 
    [Tags]    Medium
    Given I select a random destination from the list
    Then The destination will be assigned to the destination field

Scenario: Clear button for departure and destination
    [Documentation]
     ...    Verify that clearing the departure or destination field works correctly.  
    [Tags]    Medium
    When I click the clear button for the departure field
    Then The departure field input is cleared  
    When I click the clear button for the destination field
    Then The destination field input is cleared

Scenario: Verify Default Check-in and out Date in the Date picker
    [Documentation]    Verify that the date picker appears when accessing the Date field, 
     ...    with the current date selected by Default
    [Tags]    Medium
    Given I click on the calender button
    Then I see the selected dates by default

Scenario: Adding number of travallers and flight class
    [Documentation]    This scenario verifies the functionality of selecting the number of
    ...    travellers and choosing the flight class on Booking.com. It ensures that the user
    ...    can accurately specify the number of adults, children, and infants, as well as 
    ...    select the desired flight class e.g., Economy, Premium Economy, Business, or First Class
    [Tags]    Medium
    Given I click on travallers and flights class button 
    When I will see the default number of "2" travellers, "1" room, and "any class" class displayed
    Then I will see adults "-" and "+" buttons are enabled
    And I will see the any class option is selected as default



*** Settings ***
Resource    ../step-definition/frontend/stays.steps.robot
Force Tags    UC-STAYS
Suite Setup    Open BookingApp
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot
Suite Teardown    Close All Browsers

*** Test Cases ***
Scenario: Searching for the destinations field
    [Documentation]    
     ...    Verify the functionality of the destination input field
     ...    Ensure users can view suggestions for popular nearby destinations
    [Tags]    High
    Given I click on destination field
    Then The list of destinations is displayed

Scenario: Verify the list of destination field after entering input
    [Documentation]
     ...    Verify that the list of destinations on the stays page is displayed after inputing a value on the "Destiona" field
    [Tags]    High    
    Given I click on destination field
    When I enter "P" "A" in the input field
    And The list of destinations matching the input

Scenario: Assign a new destination to a destination field
    [Documentation]
     ...    Select a destination randomly from the item proposed in the list
     ...    Ensure that the new destination is assigned to the destination field 
    [Tags]    Medium
    Given I click on destination field
    When I select a random destination from the list
    Then The destination will be assigned to the destination field

Scenario: Clear the destination input field
    [Documentation]
     ...    Clear the input via Cross button 
    [Tags]    Medium    
    When I click on clear destination button
    Then The destination input is cleared

Scenario: Verify Default Check-in and out Date in the Date picker for Review step
    [Documentation]    Verify that the date picker appears when accessing the Due Date field, with the current date selected by Default
    [Tags]    Medium
    Given I access to the check-in and check-out dates
    Then The date is displayed with current date

Scenario: Check-in and Check-out Dates
    [Documentation]    Verify that when a vaid date is selected, the date appears in the field
    [Tags]    High
    Given I select a departure and a return date for my trip
    Then The selected date is displayed in the date field

Scenario: Verify default values for adults, children, and rooms
    [Documentation]    Ensure the default summary is displayed correctly when no changes are made.
    [Tags]    Medium
    Given I click on the guest selection field
    Then I will see the displayed default value as "2 adults · 0 children · 1 room"

Scenario: Attempt to enter less than 1 adult
    [Documentation]    Verify that the system does not allow the number of adults to drop below 1, and the '-' button is appropriately enabled or disabled based on the value.
    [Tags]    High
    Given I see that the '-' button is disabled when the number of adults is 1
    When I click the '+' button for adults
    Then I see the number of adults increase by 1
    And I see that the '-' button is enabled

Scenario: Select minimum number of guests without rooms
    [Documentation]    Verify the system handles the case where guests are selected without increasing the number of rooms and ensures the default room value is maintained.
    [Tags]    Low    
    Given I click the '-' button for room
    Then I see that the '-' button for rooms is disabled by default
    When I click the Done button
    Then I see the selected number of guests and the default room number displayed in the field

    

*** Settings ***
Resource    ../step-definition/frontend/flights.steps.robot
Resource    ../step-definition/frontend/home.steps.robot

Force Tags    UC-FLIGHTS
Suite Setup    Open BookingApp
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot
Suite Teardown    Close All Browsers

*** Keywords ***
    

*** Test Cases ***
Scenario: Searching for the departure field
    [Documentation]    
    ...    Verify the functionality of the departure in the flight search form
    ...    Ensure that users can find their desired location
    [Tags]    High
    Given I click on the "Flights" tab
    Then I should be redirected to the flights page
    When I click on the departure field
    Then I will see the selected airport or an empty input in the departure field
    When I type "I" "S" in the "Where from?" in the departure field
    Then I should see a list of destinations matching the input


Scenario: Searching for the destination field 
    [Documentation]    
    ...    Verify the functionality of the destination in the flight search form
    ...    Ensure that users can find their desired location
    [Tags]    High
    Given I click on the "Flights" tab
    Then I should be redirected to the flights page
    When I click on the destination field
    Then I will see the selected airport or an empty input in the destination field
    When I type "I" "S" in the "Where to?" destination field
    Then I should see a list of destinations matching the input
*** Settings ***
Resource    ../step-definition/frontend/flights.steps.robot
Resource    ../step-definition/frontend/home.steps.robot

Force Tags    UC-FLIGHTS
Suite Setup    Open BookingApp
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot
Suite Teardown    Close All Browsers

*** Test Cases ***
Scenario: Verify Flights tab navigation 
    [Documentation]    
    ...    Verify flights tab navigation functionality
    [Tags]    High
    Given I click on the "Flights" tab
    Then I should be redirected to the flights page

Scenario: Searching for the departure field
    [Documentation]    
    ...    Verify the functionality of the departure in the flight search form
    ...    Ensure that users can find their desired location
    [Tags]    High
    Given I click on the departure field
    Then I will see the selected airport or an empty input in the departure field
    When I type "T" "I" "R" in the "Where from?" in the departure field
    Then I should see a list of destinations matching the input

Scenario: Verify random departure airport selection from search
    [Documentation]    
    ...    Ensure the departure field updates with a randomly chosen airport from the search results
    [Tags]    High
    Given I select a random departure from the list
    Then The departure will be assigned to the departure field

Scenario: Searching for the destination field 
    [Documentation]    
    ...    Verify the functionality of the destination in the flight search form
    ...    Ensure that users can find their desired location
    [Tags]    High
    Given I click on the destination field
    Then I will see the selected airport or an empty input in the destination field
    When I type "S" "A" "M" in the "Where to?" destination field
    Then I should see a list of destinations matching the input

Scenario: Verify random destination airport selection from search
    [Documentation]    
    ...    Ensure the destination field updates with a randomly chosen airport from the search results
    [Tags]    High
    Given I select a random destination from the list
    Then The destination will be assigned to the destination field

Scenario: Switch origin and return destinations
    [Documentation]    
    ...    Ensure that the destination and departure fields have been switched or not
    [Tags]    High 
    Given I click on the switch button  
    Then I should see that the destination and departure are switched 

Scenario: Selecting a random date
    [Documentation]    
    ...    Verify the selection of random departure and return dates from the calendar and ensures they are displayed correctly.
    [Tags]    High
    Given The calendar button is visible
    When I click on the calendar button
    Then The calendar should be displayed
    When I select a random departure and return date
    Then The selected dates should be visible on the screen

Scenario: Checking multi-city option displays required fields
    [Documentation]    
    ...    Ensure that selecting the multi-city option displays two sets of departure and destination search boxes. 
    [Tags]    High
    Given I click the multi-city radio button
    Then I should see two departures and destinations search boxes

Scenario: Add a flight multi-city destination
    [Documentation]    
    ...    Ensure that selecting the 'Add a Flight' button displays new departure and destination search boxes 
    [Tags]    High
    Given I click on the "Add a flight" button
    Then I should see new departure and destination search boxes

Scenario: Search multiple flights for departures and destinations
    [Documentation]    
    ...     
    [Tags]    High
    Given I search new destionations and departures with dates
    Then I should see new departure and destination search boxes





#Add several flight
#Delete flight randomly
#At least two letters randomly ekle and select randomly

# Scenario: Switch origin and return destinations
#     [Documentation]    
#     ...    Ensure that the destination and departure fields have been switched or not
#     [Tags]    High 
#     Given I click on the switch button  
#     Then I should see that the destination and departure are switched  



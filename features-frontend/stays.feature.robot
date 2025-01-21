*** Settings ***
Resource    ../step-definition/frontend/home.steps.robot
Resource    ../step-definition/frontend/stays.steps.robot
Force Tags    UC-STAYS

*** Test Cases ***
Scenario: Searching for the destinations field
    [Documentation]    
     ...    Verify the functionality of the destination input field
     ...    Ensure users can view suggestions for popular nearby destinations
    [Tags]    High
    Given I click on destination field
    When I will see that field is enabled
    And I will see the list of popular nearby destinations

Scenario: Verify the list of destination field after entering input
    [Documentation]
     ...    Verify that the list of destinations on the stays page is displayed after inputing a value on the "Destiona" field
    [Tags]    High    
    Given I click on destination field
    When I enter "b" "a" in the input field
    Then The list of destinations is displayed
    And The list of destinations matching the input

Scenario: Assign a new destination to a destination field
    [Documentation]
     ...    Select a destination randomly from the item proposed in the list
     ...    Ensure that the new destination is assigned to the destination field 
    [Tags]    Medium
    Given I click on destination field
    Then I will see some destinations will be displayed
    When I select a random destination from the list
    Then The destination will be assigned to the destination field

Scenario: Clear the destination input field
    [Documentation]
     ...    Clear the input via Cross button 
    [Tags]    Medium    
    Given I click on destination field
    Then The destination input is cleared



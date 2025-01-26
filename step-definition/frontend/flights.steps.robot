*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    XML
Resource    home.steps.robot
Resource    pages/webdrivers.robot
Variables    webelements.py

*** Variables ***
${DESTINATION_OPTION_MESSAGE}    Select multiple airports at once and compare flights


*** Keywords ***
I click on the "Flights" button
    Wait Until Element Is Enabled    ${DESTINATION_FIELD}    timeout=10
    Click Element    ${FLIGHTS_PAGE}
    Sleep    2s
    ${url}=    Get Location
    Should Contain    ${url}    flights

I click on the destination field where I want to go
    Click Element    ${DESTINATION_FLIGHT}
    Click Element    ${DESTINATION_OPTION}
    Sleep    2s

I enter "I" "S" in the "Where from?" field
    Log    message
I should see a list of destinations matching the input
    Log    message
*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    XML
Resource    home.steps.robot
Resource    pages/webdrivers.robot
Variables    webelements.py

*** Variables ***
${DESTINATION_MESSAGE}    Airport or city


*** Keywords ***
I click on the "Flights" button
    Wait Until Element Is Enabled    ${DESTINATION_FIELD}    timeout=10
    Click Element    ${FLIGHTS_PAGE}
    Sleep    2s
    ${url}=    Get Location
    Should Contain    ${url}    flights

I click on the destination field where I want to go
    Click Element    ${DESTINATION_FLIGHT}
    ${destination_text}    Get Element Attribute    ${DESTINATION_TO}    placeholder
    Should Be Equal As Strings    ${DESTINATION_MESSAGE}    ${destination_text}
    Click Element    ${DESTINATION_OPTION}
    Sleep    2s

I enter "${I}" "${S}" in the "Where from?" field
    Click Element    ${DESTINATION_TO}
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_TO}    ${I}
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_TO}    ${S}
    ${input}    Get Value    ${DESTINATION_TO}
    ${input}    Convert To Lower Case    ${input}
    Set Global Variable    ${input}
    RETURN    ${input}
    Wait Until Element Is Enabled    ${input}    timeout=10

    
I should see a list of destinations matching the input
    Wait Until Element Is Visible    ${DESTINATION_FROM_CITIES}
    ${destination_from_items}    Get WebElements    ${DESTINATION_FROM_CITIES}
    ${l}=    Get Length    ${destination_from_items}
    Set Global Variable    @{destination_from_items}
    Set Global Variable    ${l}
    RETURN    ${destination_from_items}    ${l}


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
I click on the "Flights" tab
    Wait Until Element Is Enabled    ${DESTINATION_FIELD}    timeout=10
    Click Element    ${FLIGHTS_PAGE}

I should be redirected to the flights page
    ${url}=    Get Location
    Should Contain    ${url}    flights

I click on the departure field
    Click Element    ${DESTINATION_FLIGHT}

I will see the selected airport or an empty input in the departure field
    ${destination_text}    Get Element Attribute    ${DESTINATION_TO}    placeholder
    Should Be Equal As Strings    ${DESTINATION_MESSAGE}    ${destination_text}
    Click Element    ${DESTINATION_OPTION}
    Sleep    2s

I type "${I}" "${S}" in the "Where from?" in the departure field
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

I click on the destination field
    Click Element    ${DESTINATION_DP_FLIGHT}

I will see the selected airport or an empty input in the destination field
    ${destination_text}    Get Element Attribute    ${DESTINATION_TO}    placeholder
    Should Be Equal As Strings    ${DESTINATION_MESSAGE}    ${destination_text}
    Sleep    2s

I type "${I}" "${S}" in the "Where to?" destination field
    Click Element    ${DESTINATION_TO}
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_TO}    ${I}
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_TO}    ${S}
    ${input}    Get Value    ${DESTINATION_TO}
    ${input}    Convert To Lower Case    ${input}
    Set Global Variable    ${input}
    RETURN    ${input}
    Wait Until Element Is Enabled    ${input}    timeout=10

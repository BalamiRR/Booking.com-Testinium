*** Settings ***
Library    SeleniumLibrary
Resource    home.steps.robot
Resource    pages/webdrivers.robot
Variables    webelements.py

*** Variables ***
${DESTINATION_PLACEHOLDER_TEXT}    Où allez-vous ?

*** Keywords ***

I click on destination field
    Wait Until Element Is Enabled    ${DESTINATION_FIELD}    timeout=10
    ${dest_placeholder_text}    Get Element Attribute    ${DESTINATION_FIELD}    placeholder
    Should Be Equal As Strings    ${DESTINATION_PLACEHOLDER_TEXT}    ${dest_placeholder_text}
    Click Element    ${DESTINATION_FIELD}
    Sleep    2s

The list of destinations is displayed
    Wait Until Element Is Visible    ${DESTINATION_CITIES}
    @{destination_items}    Get WebElements    ${DESTINATION_CITIES}
    ${l}=    Get Length    ${destination_items}
    Set Global Variable    @{destination_items}
    Set Global Variable    ${l}
    RETURN    ${destination_items}    ${l}

When I enter "${B}" "${A}" in the input field
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_FIELD}    ${B}
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_FIELD}    ${A}
    ${input}    Get Value    ${DESTINATION_FIELD}
    ${input}    Convert To Lower Case    ${input}
    Set Global Variable    ${input}
    RETURN    ${input}

The list of destinations matching the input
    FOR    ${i}    IN RANGE    ${l}
        ${destination}=    Get Text    ${destination_items}[${i}]
        ${destination_lower}=    Convert To Lower Case    ${destination}
        Wait Until Element Contains    ${DESTINATION_CITIES}    BA
        Should Contain    ${destination_lower}    ${input}
    END

Then I will see some destinations will be displayed
    Log    message

I select a random destination from the list
    Log    message

The destination will be assigned to the destination field
    Log    message

The destination input is cleared
    Log    message


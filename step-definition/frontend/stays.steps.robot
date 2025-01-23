*** Settings ***
Library    SeleniumLibrary
Library    DateTime
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

When I enter "${P}" "${A}" in the input field
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_FIELD}    ${P}
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_FIELD}    ${A}
    ${input}    Get Value    ${DESTINATION_FIELD}
    ${input}    Convert To Lower Case    ${input}
    Set Global Variable    ${input}
    RETURN    ${input}

The list of destinations is displayed
    Wait Until Element Is Visible    ${DESTINATION_CITIES}
    ${destination_items}    Get WebElements    ${DESTINATION_CITIES}
    ${l}=    Get Length    ${destination_items}
    Set Global Variable    @{destination_items}
    Set Global Variable    ${l}
    RETURN    ${destination_items}    ${l}

The list of destinations matching the input
    FOR    ${i}    IN RANGE    ${l}
        ${destination}=    Get Text    ${destination_items}[${0}]
        ${destination_lower}=    Convert To Lower Case    ${destination}
        Should Contain    ${destination_lower}    ${input}
    END

I select a random destination from the list
    ${random_index}    Evaluate    random.randint(0, ${l}-1)
    ${destination_city}    Get WebElements    ${DESTINATION_CITIES}
    ${selected_destination}    Get Text    ${destination_city}[${random_index}]
    Set Global Variable    ${selected_destination}
    Click Element    ${destination_city}[${random_index}]
    Sleep    1s
    RETURN    ${selected_destination}

The destination will be assigned to the destination field
    ${destination_assigned}    Get Value    ${DESTINATION_FIELD}
    Should Start With   ${destination_assigned}     ${selected_destination}

I click on clear destination button
    Wait Until Element Is Visible    ${CLEAR_BTN}    5s
    Click Element    ${CLEAR_BTN}

The destination input is cleared
    Element Attribute Value Should Be    ${DESTINATION_FIELD}    value    ${EMPTY}

I access to the check-in and check-out dates
    Wait Until Element Is Visible    ${DATE_PICKER}
    Click Element    ${DATE_PICKER}
    ${SELECTED_DATE}    Get Element Attribute    ${SELECTED_DATE}    data-date
    Log    ${SELECTED_DATE}
    Set Global Variable    ${SELECTED_DATE}

The date is displayed with current date
    ${current_date}    Get Current Date    result_format=%#Y-%m-%#d
    Log    ${current_date}
    Should Be Equal    ${SELECTED_DATE}    ${current_date}
    
I select departure and return dates for my trip
    Log    message

The valid date is displayed in the date field
    Log    message
    

*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Resource    home.steps.robot
Resource    pages/webdrivers.robot
Variables    webelements.py

*** Variables ***
${DESTINATION_PLACEHOLDER_TEXT}    Where are you going?

*** Keywords ***
I click on destination field
    Wait Until Element Is Enabled    ${DESTINATION_FIELD}    timeout=10
    ${dest_placeholder_text}    Get Element Attribute    ${DESTINATION_FIELD}    placeholder
    Should Be Equal As Strings    ${DESTINATION_PLACEHOLDER_TEXT}    ${dest_placeholder_text}
    Click Element    ${DESTINATION_FIELD}
    Sleep    2s

I enter "${P}" "${A}" in the input field
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
    Set Global Variable    ${SELECTED_DATE}

The date is displayed with current date
    ${current_date}    Get Current Date    result_format=%#Y-%m-%#d
    Set Global Variable    ${current_date}
    Should Be Equal    ${SELECTED_DATE}    ${current_date}

I select a departure and a return date for my trip
    ${current_date}    Get Current Date    result_format=%#d
    ${DEPARTURE_DATE}    Set Variable    xpath=//span[text()='${current_date}']
    Wait Until Element Is Visible    ${DEPARTURE_DATE}    
    Double Click Element    ${DEPARTURE_DATE}  
    Set Global Variable    ${DEPARTURE_DATE}

    ${current_date}=    Get Current Date
    ${date}=    Add Time To Date    ${current_date}    1 days    result_format=%#d
    ${RETURN_DATE}    Set Variable    xpath=//span[text()='${date}']
    Set Global Variable    ${RETURN_DATE}
    Wait Until Element Is Visible    ${RETURN_DATE}
    Double Click Element    ${RETURN_DATE}
    Log    ${RETURN_DATE}

The selected date is displayed in the date field
    ${field_departure}    Get Text    ${DEPARTURE_FIELD}
    ${field_return}    Get Text    ${RETURN_FIELD}
    ${destination_field}    Set Variable    ${field_departure} — ${field_return}
    
    ${formatted_departure_date}    Convert Date    ${current_date}    result_format=%a, %b %d
    ${date}=    Add Time To Date    ${current_date}    1 days    result_format=%#Y-%m-%#d
    ${formatted_return_date}    Convert Date    ${date}    result_format=%a, %b %d
    ${formatted_destination}    Set Variable    ${formatted_departure_date} — ${formatted_return_date}
    Should Be Equal As Strings    ${formatted_destination}    ${destination_field} 


I click on the guest selection field
    Log    message
I will see the displayed default value as "2 adults · 0 children · 1 room"
    Log    message


I see that the '-' button is disabled when the number of adults is 1
    Log    message
I click the '+' button for adults
    Log    message
I see the number of adults increase by 1
    Log    message
I see that the '-' button is enabled
    Log    message

I click the '-' button for room
    Log    message
I see that the '-' button for rooms is disabled by default
    Log    message
I click the Done button
    Log    message
I see the selected number of guests and the default room number displayed in the field
    Log    message
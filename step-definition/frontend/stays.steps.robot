*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    XML
Resource    home.steps.robot
Resource    pages/webdrivers.robot
Variables    webelements.py

*** Variables ***
${DESTINATION_PLACEHOLDER_TEXT}    Where are you going?

*** Keywords ***
The language preferences
    Click Element    ${LANGUAGE_PREF_DRAWER}
    Sleep    5s
    Click Element    ${LANGUAGE_ENG}
    Sleep    5s

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
    Set Global Variable    ${SELECTED_DATE}

The date is displayed with current date
    ${current_date}    Get Current Date    result_format=%#Y-%m-%#d
    Set Global Variable    ${current_date}
    Should Be Equal    ${SELECTED_DATE}    ${current_date}

I select a departure and return dates for my trip
    ${departure_date}    Add Time To Date    ${current_date}    5 days    result_format=%#Y-%m-%#d
    ${departure_locator}    Get Element Attribute    xpath=//span[@data-date='${departure_date}']    ${departure_date} 
    Click Element    ${departure_locator}
    #${departure_date}=    Get Current Date    result_format=%Y-%m-%d    increment=5 days
    ${return_date}    Add Time To Date    ${departure_date}    10 days    result_format=%#Y-%m-%#d    
    ${return_locator}    Get Element Attribute    xpath=//span[@data-date='${return_date}']    ${return_date}
    Wait Until Element Is Visible    ${return_locator}
    Click Element    ${return_locator}

The selected date is displayed in the date field
    Log    message
    



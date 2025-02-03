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
    ${YEAR}    Set Variable    ${SELECTED_DATE.split("-")[0]}
    ${MONTH}    Set Variable    ${SELECTED_DATE.split("-")[1]}
    ${DAY}    Set Variable    ${SELECTED_DATE.split("-")[2]}
    ${FORMATTED_SELECTED_DATE}    Set Variable    ${MONTH.lstrip("0")}/${DAY.lstrip("0")}/${YEAR}
    Set Global Variable    ${FORMATTED_SELECTED_DATE}

The date is displayed with current date
    ${current_date}    Get Current Date    result_format=%#m/%#d/%Y
    ${month}    ${day}    ${year}=    Split String    ${current_date}    /
    ${month}    Convert To Integer    ${month}
    ${day}    Convert To Integer    ${day}
    ${formatted_date}    Set Variable    ${month}/${day}/${year}
    Should Be Equal    ${FORMATTED_SELECTED_DATE}    ${formatted_date}

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
    
    Sleep    2s
    ${current_date}    Get Current Date    result_format=%Y-%m-%d
    ${formatted_departure_date}    Evaluate    "{:%a, %b %d}".format(datetime.datetime.strptime("${current_date}", "%Y-%m-%d")).replace(" 0", " ")    modules=datetime
    ${date}    Add Time To Date    ${current_date}    1 days    result_format=%Y-%m-%d
    ${formatted_return_date}    Evaluate    "{:%a, %b %d}".format(datetime.datetime.strptime("${date}", "%Y-%m-%d")).replace(" 0", " ")    modules=datetime

    ${formatted_destination}    Set Variable    ${formatted_departure_date} — ${formatted_return_date}
    Should Be Equal As Strings    ${formatted_destination}    ${destination_field} 

I click on the guest selection field
    Click Element    ${GUEST_OPTION_BTN}

I will see the displayed default value as "${adults}" adults · "${children}" children · "${room}" room
    ${adults_value}    Get Element Attribute    ${ADULTS_NUMBER}    value
    Set Global Variable    ${adults_value}
    Should Be Equal As Strings    ${adults_value}    ${adults}

    ${children_value}    Get Element Attribute    ${CHILDREN_NUMBER}    value
    Should Be Equal As Strings    ${children_value}    ${children}

    ${rooms_value}    Get Element Attribute    ${ROOM_NUMBER}    value
    Should Be Equal As Strings    ${rooms_value}    ${room}
    # ${summary_value}    Get Text    ${GUEST_FIELD}
    # Should Be Equal As Strings    ${summary_value}    "2 adults · 0 children · 1 room"

I see that the '-' button is enabled
    Element Should Be Enabled    ${ADULT_MINUS_BTN}

When I click the '-' button for adults
    Click Element    ${ADULT_MINUS_BTN}

I see the number of adults decrease by 1
    ${new_adults}    Get Element Attribute    ${ADULTS_NUMBER}    value
    ${expected_adults}    Evaluate    ${adults_value} - 1
    Should Be Equal As Strings    ${new_adults}    ${expected_adults}

I see that the '-' button is disabled
    Element Should Not Be Visible    ${ADULT_MINUS_BTN}

# I click the '+' button for adults
#     Click Element    ${ADULT_PLUS_BTN}

# I click the '-' button for room
#     Log    message

# I see that the '-' button for rooms is disabled by default
#     Log    message

# I click the Done button
#     Log    message

# I see the selected number of guests and the default room number displayed in the field
#     Log    message

# There are no children selected
#     Log    message

# I click the '+' button for children
#     Log    message

# I see the number of children increase by 1
#     Log    message

# I see the "Age needed" field is displayed for the added child
#     Log    message

# I click the "Age needed" field
#     Log    message

# I will see the list of ages 
#     Log    message

# I select a random age from the list
#     Log    message

# The age will be assigned to the field
#     Log    message
    
# I see the selected number of child is displayed in the field
#     Log    message

*** Comments ***
The date is displayed with current date
    ${current_date}    Get Current Date    result_format=%#Y-%m-%#d
    Set Global Variable    ${current_date}
    Should Be Equal    ${SELECTED_DATE}    ${current_date}
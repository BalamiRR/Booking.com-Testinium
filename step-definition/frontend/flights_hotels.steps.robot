*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    pages/tests/CommonStringOperation.py
Resource    home.steps.robot
Resource    pages/webdrivers.robot
Variables    webelements.py

*** Variables ***

*** Keywords ***
I will be redirected to the Flight and Hotel page
    Click Element    ${FLIGHT_HOTEL_BTN}
    Successfull redirection to the flight and hotel page    ${FLIGHT_HOTEL_PAGE}

I select the english language on the top
    Wait Until Element Is Visible    ${FLIGHT_HOTEL_ACCEPT_COOKIES}
    Click Element    ${FLIGHT_HOTEL_ACCEPT_COOKIES}
    Wait Until Element Is Visible     ${FLIGHT_HOTEL_LANGUAGE}
    Click Element    ${FLIGHT_HOTEL_LANGUAGE}
    Click Element    ${FLIGHT_HOTEL_ENGLISH}

I click on the departure field
    Click Element    ${DEPARTURE_FLIGHT_HOTEL_FIELD}

I see that the departure field is active
    Element Should Be Enabled    ${DEPARTURE_FLIGHT_HOTEL_FIELD}

I enter at least one letter "${O}" 
    Clear Element Text    ${DEPARTURE_FLIGHT_HOTEL_FIELD}
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DEPARTURE_FLIGHT_HOTEL_FIELD}    ${O}
    ${input}    Get Value    ${DEPARTURE_FLIGHT_HOTEL_FIELD}
    ${input}    Convert To Lower Case    ${input}
    Set Global Variable    ${input}
    RETURN    ${input}

I see related cities or airports as suggestions
    Sleep    2s
    Wait Until Element Is Visible    ${LIST_OF_DEPARTURE}
    ${departure_items}    Get WebElements    ${LIST_OF_DEPARTURE}
    ${l}=    Get Length    ${departure_items}
    RETURN    ${departure_items}    ${l}

I select a random departure from the list
    ${departure_items}    ${departure_count}    I see related cities or airports as suggestions
    ${random_index}    Evaluate    random.randint(0, ${departure_count}-1)
    ${selected_departure}    Get Text    ${departure_items}[${random_index}]
    # ${selected_departure} =    Strip String    ${selected_departure}
    #${selected_departure} =    Normalize String    ${selected_departure}
    Click Element    ${departure_items}[${random_index}]
    Sleep    1s
    Set Global Variable    ${selected_departure}
    RETURN    ${selected_departure}

The departure will be assigned to the departure field
    ${departure_assigned}    Get Value    ${ASSIGNED_DEPARTURE}
    Should Contain   ${selected_departure}    ${departure_assigned}
    
I click on the destination field
    Click Element    ${DESTINATION_FLIGHT_HOTEL_FIELD}

I see that the destination field is active
    Element Should Be Enabled    ${DESTINATION_FLIGHT_HOTEL_FIELD}

I enter a letter "${I}"
    Clear Element Text    ${DESTINATION_FLIGHT_HOTEL_FIELD}
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_FLIGHT_HOTEL_FIELD}    ${I}
    ${input_destination}    Get Value    ${DESTINATION_FLIGHT_HOTEL_FIELD}
    ${input_destination}    Convert To Lower Case    ${input_destination}
    Set Global Variable    ${input_destination}
    RETURN    ${input_destination}

I see related cities or airports for destination
    Sleep    15s
    #Wait Until Element Is Visible    ${LIST_OF_DESTINATION}    3s
    ${destination_items}    Get WebElements    ${LIST_DESTINATIONS}
    Sleep    5s
    ${l}=    Get Length    ${destination_items}
    RETURN    ${destination_items}    ${l}

 I select a random destination for hotels and flights from the list
    ${destination_items}    ${destination_count}    I see related cities or airports for destination
    ${random_index}    Evaluate    random.randint(0, ${destination_count}-1)
    ${selected_destination}    Get Text    ${destination_items}[${random_index}]
    Click Element    ${destination_items}[${random_index}]
    Sleep    1s
    Set Global Variable    ${selected_destination}
    RETURN    ${selected_destination}

I will see that destination will be assigned to the destination field
    ${destination_assigned}    Get Value    ${ASSIGNED_DESTINATION}
    Should Contain  ${selected_destination}    ${destination_assigned}

I click the clear button for the departure field
    Wait Until Element Is Visible    ${CLEAR_DEPARTURE_DESTINATION}    5s
    Click Element    ${CLEAR_DEPARTURE_DESTINATION}

The departure field input is cleared
    Element Attribute Value Should Be    ${DEPARTURE_FLIGHT_HOTEL_FIELD}    value    ${EMPTY}

I click the clear button for the destination field
    Wait Until Element Is Visible    ${CLEAR_DEPARTURE_DESTINATION}    5s
    Click Element    ${CLEAR_DEPARTURE_DESTINATION}

The destination field input is cleared
    Element Attribute Value Should Be    ${DESTINATION_FLIGHT_HOTEL_FIELD}    value    ${EMPTY}

I click on the calender button
    Click Element    ${CALENDER}

I see the selected dates by default
    Wait Until Page Contains Element    ${SELECTED_DATE_FOR_FLIGHTS_HOTELS}
    ${selected_dates}=    Get WebElements    ${SELECTED_DATE_FOR_FLIGHTS_HOTELS}
    ${length}=    Get Length    ${selected_dates}

    Should Be True    ${length} >= 2

    FOR    ${index}    IN RANGE    ${length}
        ${date}=    Get From List    ${selected_dates}    ${index}
        ${text}=    Get Text    ${date}
        Log    Selected date: ${text}
    END

    ${departure_date}=    Get Text    ${selected_dates[0]}
    ${return_date}=    Get Text    ${selected_dates[-1]}

I click on travallers and flights class button
    Click Element    ${TRAVELLERS_FLIGHT_FIELD}

Extract Room Number
    [Arguments]    ${text}
    ${room_number}=    Evaluate    re.search(r'(\\d+)$', '''${text}''').group(1)    modules=re
    RETURN    ${room_number}

I will see the default number of "${travellers}" travellers, "${room}" room, and "${any_class}" class displayed
    Sleep    2s
    ${travellers_value}    Get Text    ${TRAVELLER_COUNT}    
    Should Be Equal As Strings    ${travellers_value}    ${travellers}

    ${room_number}    Get Text    ${TRAVELLERS_ROOM_NUMBER}    
    ${room_number}=    Extract Room Number    ${room_number}
    Should Be Equal As Strings    ${room_number}    ${room}

    ${flight_class}    Get Text    ${ANY_FLIGHT}
    Should Be Equal As Strings    ${flight_class}    ${any_class}
    
I will see adults "-" and "+" buttons are enabled
    Element Should Be Enabled    ${FH_MINUS_BTN}
    Element Should Be Enabled    ${FH_PLUS_BTN}

I will see the any class option is selected as default
    Element Should Be Enabled    ${ANY_FLIGHT}

I click on the "Add a child" option
    Sleep    2s
    Wait Until Element Is Visible    ${ADD_CHILD_BTN}
    Click Element    ${ADD_CHILD_BTN}
    
I will see the list of ages til 12 years
    Wait Until Element Is Visible    ${AGE_LIST}
    ${age_items}    Get WebElements    ${AGE_LIST}
    ${length_of_ages}=    Get Length    ${age_items}
    Set Global Variable    @{age_items}
    Set Global Variable    ${length_of_ages}
    RETURN    ${age_items}    ${length_of_ages}

I select a random age for the child from the list
    ${age_items}    ${age_numbers}    I will see the list of ages til 12 years
    ${random_age}    Evaluate    random.randint(1,${age_numbers}-1)
    ${selected_age}    Get Text    ${age_items}[${random_age}]
    Sleep    2s
    Click Element    ${age_items}[${random_age}]
    Sleep    1s
    Set Global Variable    ${selected_age}
    RETURN    ${selected_age}

I will see the newly added child's age displayed
    Element Should Be Visible    ${ADDED_CHILD_FIELD}

I click on the "Add a Room" button
    Wait Until Element Is Visible    ${ADD_ROOM_BTN}
    Click Element    ${ADD_ROOM_BTN}

I should see the newly added room displayed next to the first one
    Element Should Be Visible    ${ADDED_NEW_ROOM}

I will see the popular cities contain "${Amsterdam Netherlands}" "${Tenerife Canary Islands}" "${Dubai United Arab Emirates}" "${New York - Manhattan United States}" "${Barcelona Spain}" "${Lanzarote Canary Islands}" "${Paris France}" "${Prague Czech Republic}" "${Rome Italy}" "${Antalya region Turkey}" 
    ${destination_list}=    Create List    ${Amsterdam Netherlands}    ${Tenerife Canary Islands}     ${Dubai United Arab Emirates}    
    ...    ${New York - Manhattan United States}    ${Barcelona Spain}    ${Lanzarote Canary Islands}    ${Paris France}    
    ...    ${Prague Czech Republic}    ${Rome Italy}    ${Antalya region Turkey}     
    Wait Until Page Contains Element    ${LIST_OF_DESTINATION}    20s
    ${list_destination_count}    Get Element Count    ${LIST_OF_DESTINATION}
    ${list_destination_count}    Convert To Integer    ${list_destination_count}     
    ${list_number}    Convert To String    ${list_destination_count}   
    FOR    ${index}    IN RANGE    1    ${list_destination_count}
        ${random_destination_list_text}    Get Text    //ul[@class='d-1ip0gkj']//li[@id='listbox-option-${index}']
        ${random_destination_list_text}    Replace String    ${random_destination_list_text}    \n    ${SPACE}
        List Should Contain Value    ${destination_list}    ${random_destination_list_text}
    END

 I click on the search button
    Sleep    2s
    Click Button    ${FH_SEARCH_BTN}

I will see mandatory fields
    Element Should Be Visible    ${DEPARTURE_ALERT}
    Element Should Be Visible    ${DESTINATION_ALERT}
    ${departure_alert}    Get Text    ${DEPARTURE_ALERT}
    ${destination_alert}    Get Text    ${DESTINATION_ALERT}

    Should Be Equal As Strings    ${departure_alert}    Enter departure city or airport
    Should Be Equal As Strings    ${destination_alert}    Enter a destination

I select a random destionation and destination city
    I enter at least one letter "O"
    I select a random departure from the list
    The departure will be assigned to the departure field
    I select a random destination for hotels and flights from the list
    I will see that destination will be assigned to the destination field

I will be redirected to the flight search results page
    I click on the search button
    Wait Until Location Contains    ${FH_REDIRECTION_TO_SEARCH_RESULT}
    Wait Until Element Is Visible    ${FH_SEARCH_RESULT}

I see at least "${all_list}" hotels listed by default
    Sleep    40s
    ${lists_hotels}    Get Element Count    ${LIST_OF_HOTELS}
    ${all_list}    Convert To Integer    ${all_list}
    ${lists_hotels}    Convert To Integer    ${lists_hotels}
    Set Global Variable    ${all_list}
    Set Global Variable    ${lists_hotels}
    Should Be True    ${all_list} >= ${lists_hotels}

I click the "All Filters" button at the top
    Wait Until Element Is Visible    ${ALL_FILTERS_BTN}
    Click Button    ${ALL_FILTERS_BTN}

I should see the filters menu displayed
    Sleep    2s
    Element Should Be Visible    ${FILTERS_DISPLAY}

I will see the headers "${Deals}" "${Destination airport}" "${Budget}" "${Flight}" "${Property type}" "${Property name}" "${Stars}" "${Meal plan}" "${Guest rating}" "${Facilities}" "${Nearest beach}" "${Area}" "${Nearest station}" "${Hotel chain}" "${Property style}"
    ${filters_headers}=    Create List    ${Deals}    ${Destination airport}    ${Budget}     
    ...    ${Flight}    ${Property type}    ${Property name}    ${Stars}    
    ...    ${Meal plan}    ${Guest rating}    ${Facilities}    ${Nearest beach} 
    ...    ${Area}    ${Nearest station}    ${Hotel chain}    ${Property style}

    ${header_elements}=    Get WebElements    ${FILTERS_HEADER}  

    ${header_list}=    Create List
    FOR    ${element}    IN    @{header_elements}
        ${text_header}=    Get Text    ${element}
        Append To List    ${header_list}    ${text_header}
        Log    ${header_list}
    END

    ${matched_headers}=    Create List
    FOR    ${header}    IN    @{header_list}
        Run Keyword If    '${header}' in ${filters_headers}    Append To List    ${matched_headers}    ${header}
    END

    RETURN    ${matched_headers}
    
I click on the radio button for "Flash Sales"
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${FLASH_SALES_BTN}
    Run Keyword If    ${is_visible}    Click Element    ${FLASH_SALES_BTN}
    
I should see the radio button turn on
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${FLASH_SALES_BTN}
    Run Keyword If    ${is_visible}    Wait Until Element Is Enabled    ${FLASH_SALES_BTN}
    Run Keyword If    ${is_visible}    Element Should Be Enabled    ${FLASH_SALES_BTN}

I click on the radio button for "Flash Sales" again
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${FLASH_SALES_BTN}
    Run Keyword If    ${is_visible}    Click Button    ${FLASH_SALES_BTN}

I will see the radio button turn off
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${FLASH_SALES_BTN}
    Run Keyword If    ${is_visible}    Element Should Be Disabled    ${FLASH_SALES_BTN}

I hover over the minimum budget slider and set it to 700 pounds
    Log    message

I should see the minimum value set to 700
    Log    message

# I select the 3-star option from the Stars filter
#     Log    message

# I should see the selected checkbox
#     Log    message

# I select the "Random only" option for the meal plan
#     Log    message

# I should see the "Random only" option selected
#     Log    message

# I click the "Apply" button
#     Log    message

# I will be redirected to the hotels result page
#     Log    message

# I select a random hotel
#     # ${get_random_hotels}    Evaluate    random.randint(1, ${lists_hotels}-1)
#     # ${FORMULA_DESCRIPTION_DEL_TEMP}    Replace In String    ${RANDOM_HOTELS}    ${get_random_hotels}${EMPTY}
#     Log    message
# I will be redirected to the hotel details page
#     Log    message

*** Comments ***
I see related cities or airports as suggestions
    Wait Until Element Is Visible    ${LIST_OF_DEPARTURE}
    ${departure_items}    Get WebElements    ${LIST_OF_DEPARTURE}
    ${l}=    Get Length    ${departure_items}
    Set Global Variable    @{departure_items}
    Set Global Variable    ${l}
    RETURN    ${departure_items}    ${l}

I select a random departure from the list
    ${random_index}    Evaluate    random.randint(0, ${l}-1)
    ${departure_city}    Get WebElements    ${LIST_OF_DEPARTURE}
    ${selected_departure}    Get Text    ${departure_city}[${random_index}]
    Set Global Variable    ${selected_departure}
    Click Element    ${departure_city}[${random_index}]
    Sleep    1s
    RETURN    ${selected_departure}

========== PURUSH ==========

I access sample definition view and add multiple candidats
   Wait Until Page Contains Element    ${BTN_SAMPLE_DEFINITONS}    10s
   Click Button    ${BTN_SAMPLE_DEFINITONS}
   Wait Until Element Is Visible    ${ADD_CANDIDATE_BTN}
   Click Element    ${ADD_CANDIDATE_BTN}   
   Sleep    5s
   # OTHER TAB: From Line 22 TO Line 23
   # Click Element    ${OTHER_TAB}
   # Sleep    5s

   Click Element    ${OTHER_TAB}
   Sleep    5s
   FOR    ${i}    IN RANGE    0    10
      ${j}    Evaluate    ${i}+1
      ${i}    Convert To String    ${i} 
      ${FORMULA_DESCRIPTION_DEL_TEMP}    Replace In String    ${FORMULA_DESCRIPTION_GEN}    ${i}
      ${Value_Input} =	Catenate	formula description	${j}
      Input Text    ${FORMULA_DESCRIPTION_DEL_TEMP}    ${Value_Input}
      Click Element    ${ADD_ANOTHER_FORMULA_BTN}	     
   END 
   Click Element    ${ADD_CANDIDATE_DRAWER_BTN}
   Sleep    8s
   Click Element    ${EXIT_CANDIDATE_DRAWER_CROSS}

The Table of the application Sample contains "${Number of Items}" "${Trial No.}" "${Formula Code and Mix Components}" "${Oil availability}" "${Base dosage}" "${Packaging}" "${Actions}" 
    ${Sample_Tab_head_lists}=    Create List    ${Number of Items}     ${Trial No.}    ${Formula Code and Mix Components}    ${Oil availability}    ${Base dosage}    ${Packaging}    ${Actions}     
    Wait Until Page Contains Element    ${APP_SAMPLES_TAB}    20s
    ${App_Samples_Tab_Count}    Get Element Count    ${APP_SAMPLES_TAB}
    ${App_Samples_Tab_Count}    Convert To Integer    ${App_Samples_Tab_Count}    
    ${random_table_number}    Evaluate    random.randint(1,${App_Samples_Tab_Count})    
    ${random_table_number}    Convert To String    ${random_table_number}    
    ${APP_SAMPLES_HEADER_RANDOM}    Replace In String    ${APP_SAMPLES_TAB_HEADER}    ${random_table_number}  
    ${APP_SAMPLES_HEADER_COUNT}    Get Element Count    ${APP_SAMPLES_HEADER_RANDOM}    
    FOR    ${index}    IN RANGE    1    ${APP_SAMPLES_HEADER_COUNT}+1 
        ${App_Samples_Tab_Heads}    Catenate    SEPARATOR=    ${APP_SAMPLES_HEADER_RANDOM}    :nth-child(${index})        
        ${App_Samples_Tab_Head_Text}    Get Text    ${App_Samples_Tab_Heads}       
        List Should Contain Value    ${Sample_Tab_head_lists}    ${App_Samples_Tab_Head_Text}
    END 

============================
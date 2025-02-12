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
    Click Element    ${DEPARTURE_FLIGHT}

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
    Sleep    2s
    RETURN    ${destination_from_items}    ${l}

I click on the destination field
    Click Element    ${DESTINATION_FLIGHT}

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

I click on the switch button 
    ${departure_before}    Get Text    ${DEPARTURE_FLIGHT}
    Set Global Variable    ${departure_before}
    ${destination_before}  Get Text    ${DESTINATION_FLIGHT}
    Set Global Variable    ${destination_before}
    Click Element    ${SWITCH_BUTTON}
  
I should see that the destination and departure are switched  
    ${departure_after}    Get Text    ${DEPARTURE_FLIGHT}
    ${destination_after}  Get Text    ${DESTINATION_FLIGHT} 
    Should Be Equal    ${departure_before}    ${destination_after}
    Should Be Equal    ${destination_before}  ${departure_after}

I select a random departure from the list
    ${random_index}    Evaluate    random.randint(0, ${l}-1)
    ${destination_from_city}    Get WebElements    ${DESTINATION_LIST}
    ${selected_destination}    Get Text    ${destination_from_city}[${random_index}]
    Set Global Variable    ${selected_destination}
    Click Element    ${destination_from_city}[${random_index}]
    Log  ${selected_destination}
    Sleep    1s
    RETURN    ${selected_destination}

The departure will be assigned to the departure field
    ${destination_assigned}    Get Text    ${DEPARTURE_FLIGHT_DETAIL}
    Should Be Equal  ${destination_assigned}     ${selected_destination}

I select a random destination from the list
    ${random_index}    Evaluate    random.randint(0, ${l}-1)
    ${destination_to_city}    Get WebElements    ${DESTINATION_LIST}
    ${selected_destination_to}    Get Text    ${destination_to_city}[${random_index}]
    Set Global Variable    ${selected_destination_to}
    Click Element    ${destination_to_city}[${random_index}]
    Log  ${selected_destination_to}
    Sleep    1s
    RETURN    ${selected_destination_to}

The destination will be assigned to the destination field
    ${selected_destination_to}    Get Text    ${DESTINATION_FLIGHT_DETAIL}
    Should Be Equal  ${selected_destination_to}     ${selected_destination_to}



*** Comments ***
I click on the switch button 
    Set Global Variable    ${departure_before}    Get Element    ${DEPARTURE_FLIGHT}
    Set Global Variable    ${destination_before}  Get Element    ${DESTINATION_FLIGHT}
    Click Element    ${SWITCH_BUTTON}
  
I should see that the destination and departure are switched 
    ${departure_after}    Get Text    ${DESTINATION_FLIGHT}
    ${destination_after}  Get Text    ${DEPARTURE_FLIGHT} 
    Should Be Equal    ${departure_before}    ${destination_after}
    Should Be Equal    ${destination_before}  ${departure_after}

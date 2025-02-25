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

I type "${T}" "${I}" "${R}" in the "Where from?" in the departure field
    Click Element    ${DESTINATION_TO}
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_TO}    ${T}
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_TO}    ${I}
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_TO}    ${R}
    ${input}    Get Value    ${DESTINATION_TO}
    ${input}    Convert To Lower Case    ${input}
    Set Global Variable    ${input}
    RETURN    ${input}
    Wait Until Element Is Enabled    ${input}    timeout=10

I should see a list of destinations matching the input
    Wait Until Element Is Visible    ${DESTINATION_FROM_CITIES}
    ${destination_from_items}    Get WebElements    ${DESTINATION_FROM_CITIES}
    ${l} =    Get Length    ${destination_from_items}
    Set Global Variable    @{destination_from_items}
    Set Global Variable    ${l}
    Sleep    1s
    RETURN    ${destination_from_items}    ${l}

I click on the destination field
    Click Element    ${DESTINATION_FLIGHT}

I will see the selected airport or an empty input in the destination field
    ${destination_text}    Get Element Attribute    ${DESTINATION_TO}    placeholder
    Should Be Equal As Strings    ${DESTINATION_MESSAGE}    ${destination_text}
    Sleep    2s

I type "${S}" "${A}" "${M}" in the "Where to?" destination field
    Click Element    ${DESTINATION_TO}
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_TO}    ${S}
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_TO}    ${A}
    Wait Until Keyword Succeeds    1s    2s    Press Key    ${DESTINATION_TO}    ${M}
    ${input}    Get Value    ${DESTINATION_TO}
    ${input}    Convert To Lower Case    ${input}
    Set Global Variable    ${input}
    RETURN    ${input}
    Wait Until Element Is Enabled    ${input}    timeout=10

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
    Log    ${destination_to_city}
    ${selected_destination_to}    Get Text    ${destination_to_city}[${random_index}]
    Set Global Variable    ${selected_destination_to}
    Click Element    ${destination_to_city}[${random_index}]
    Log  ${selected_destination_to}
    Sleep    1s
    RETURN    ${selected_destination_to}

The destination will be assigned to the destination field
    ${selected_destination_to}    Get Text    ${DESTINATION_FLIGHT_DETAIL}
    Should Be Equal  ${selected_destination_to}     ${selected_destination_to}

I click the multi-city radio button
    Click Element    ${MULTI_CITY_RADIO_BUTTON}

I should see two departures and destinations search boxes
    ${search_multi_dest}  Get WebElements  ${SEARCH_MULTI_DESTINATION_BOXES}
    Length Should Be    ${search_multi_dest}    2

I click on the "Add a flight" button
    ${click_count}    Evaluate    random.randint(1, 3)    modules=random
    Sleep   2s
    FOR    ${i}    IN RANGE    0    ${click_count}
        Click Element    ${ADD_FLIGHT_BUTTON}
        Sleep    2s
    END

    ${total_flights}    Evaluate    1 + ${click_count}
    Set Global Variable    ${total_flights}

    FOR    ${i}    IN RANGE    1    ${total_flights}+1
        FOR    ${type}    IN    departure    destination
            ${index}    Run Keyword If    '${type}' == 'departure'    Evaluate    ${i} * 6 + 1
            ...    ELSE    Evaluate    ${i} * 6 + 3

            ${xpath}    Set Variable    xpath=(//span[contains(@class,'SbZm6')])[${index}]
            Click Element    ${xpath}
            Click Element    ${DESTINATION_TO}

            ${random_text}    Evaluate    ''.join(random.choices('ABCDEFGHIJKLMNOPQRSTUVWXYZ', k=2))    modules=random,string
            Input Text    ${DESTINATION_TO}    ${random_text}
            I should see a list of destinations matching the input
            I select a random departure from the list

        END
    END

I should see new departure and destination search boxes
    ${search_multi_dest}  Get WebElements  ${SEARCH_MULTI_DESTINATION_BOXES}
    ${expected_flights}    Evaluate    ${total_flights} + 1
    Length Should Be    ${search_multi_dest}    ${expected_flights}




*** Comments ***


${destination_field}    Get WebElement    xpath=(//input[contains(@placeholder, 'Destination')])[${i + 1}]

        # Rastgele 2 harfli kodlar oluştur
        ${departure_code}    Evaluate    ''.join(random.choices('ABCDEFGHIJKLMNOPQRSTUVWXYZ', k=2))    modules=random,string
        ${destination_code}    Evaluate    ''.join(random.choices('ABCDEFGHIJKLMNOPQRSTUVWXYZ', k=2))    modules=random,string

        # Departure ve Destination alanlarına rastgele yaz
        Input Text    ${departure_field}    ${departure_code}
        Sleep    1s
        Input Text    ${destination_field}    ${destination_code}
        Click Element    ${ADD_FLIGHT_BUTTON} 
        Sleep    2s

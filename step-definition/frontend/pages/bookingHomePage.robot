*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Keywords ***
Successfull redirection
    [Arguments]    ${url}
    Wait Until Location Is    ${url}    timeout=15

Verify element text
    [Arguments]    ${webelement}
    Wait Until Page Contains Element    ${webelement}    20s
    ${text_is}=    Get Text    ${webelement}
    RETURN    ${text_is}

Successfull redirection to the flight and hotel page
    [Arguments]    ${url_flight_hotel}
    Location Should Contain    ${url_flight_hotel}    timeout=15

Get Matching Items
    [Arguments]    ${list1}    ${list2}
    ${matching_items}=    Create List
    FOR    ${item}    IN    ${list1}
        Run Keyword If    ${item} in ${list2}    Append To List    ${matching_items}    ${item}
    END
    [Return]    ${matching_items}
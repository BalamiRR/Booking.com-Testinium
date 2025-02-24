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
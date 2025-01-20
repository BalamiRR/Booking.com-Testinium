*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Keywords ***
Successfull redirection
    [Arguments]    ${url}
    Wait Until Location Is    ${url}    timeout=15

Verify element text
    [Arguments]    ${webelement}
    ${text_is}=    Wait Until Page Contains Element    ${webelement}    20s
    RETURN    ${text_is}



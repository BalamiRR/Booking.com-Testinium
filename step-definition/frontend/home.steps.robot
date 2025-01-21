*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Variables    webelements.py
Resource    pages/webdrivers.robot
Resource    pages/bookingHomePage.robot

*** Keywords ***
Open BookingApp
    ${URL} =    Run Keyword If    "${BROWSER}" == 'chrome'
        ...    Create Chrome browser    ${BROWSER}
        ...    ELSE IF    "${BROWSER}" == 'edge'
        ...    Run Keyword    Create edge browser    ${BROWSER}
        ...    ELSE
        ...    Fail    The browser selection is not valid
    Maximize Browser Window
    Set Global Variable    ${URL}
    RETURN    ${URL}

The header contain the logo of BookingApp
    Wait Until Page Contains Element    ${APP_LOGO}
    Click Element    ${APP_LOGO}

The header contains the navigation menu
    Wait Until Page Contains Element    ${NAV_MENU}
    ${tabs}=    Get WebElement    ${NAV_MENU}
    
*** Settings ***
Library    SeleniumLibrary
Variables    webelements.py
Resource    pages/webdrivers.robot
Resource    pages/bookingHomePage.robot

*** Keywords ***
Open BookingApp
    ${URL}=    Run Keyword If    "${BROWSER}" == 'chrome'
        ...    Create Chrome browser    ${BROWSER}
        ...    ELSE IF    "${BROWSER}" == 'edge'
        ...    Run Keyword    Create edge browser    ${BROWSER}
        ...    ELSE IF    "${BROWSER}" == 'firefox'
        ...    Run Keyword    Create edge browser    ${BROWSER}
        ...    ELSE
        ...    Fail    The browser selection is not valid
    Maximize Browser Window
    Accept Cookies
    The language preferences
    Set Global Variable    ${URL}
    RETURN    ${URL}

The header contain the logo of BookingApp
    Wait Until Page Contains Element    ${APP_LOGO}
    Click Element    ${APP_LOGO}

The header contains the navigation menu
    Wait Until Page Contains Element    ${NAV_MENU}
    ${tabs}=    Get WebElement    ${NAV_MENU}
    
Accept Cookies
    Click Element    css=${ACCEPT_COOKIES}

The language preferences
    Click Element    ${LANGUAGE_PREF_DRAWER}
    Wait Until Element Is Visible    ${LANGUAGE_ENG}
    Click Element    ${LANGUAGE_ENG}
    Sleep    5s
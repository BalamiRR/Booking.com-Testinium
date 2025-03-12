*** Settings ***
Library    SeleniumLibrary    timeout=0:00:05    implicit_wait=0:00:05
Library    Collections
Library    String
Library    ../../../configuration/readProperty.py

* Variables *
${ENVIRONMENT}
${BROWSER}
${RESOLUTION}

* Keywords *
Create Chrome browser
   [Arguments]   ${BROWSER}
   ${URL}=   readProperty.get_main_url   ${ENVIRONMENT}
   ${chrome_options}=   Evaluate   sys.modules['selenium.webdriver'].ChromeOptions()   sys, selenium.webdriver
   Call Method   ${chrome_options}   add_argument   --no-sandbox
   Call Method   ${chrome_options}   add_argument   --headless  
   Call Method   ${chrome_options}   add_argument   --disable-gpu
   Call Method   ${chrome_options}   add_argument   --disable-infobars
   Call Method   ${chrome_options}   add_argument   --disable-extensions
   Call Method   ${chrome_options}   add_argument   --disable-dev-shm-usage
   Open Browser   ${URL}   browser=${BROWSER}   options=${chrome_options}
   # ${width}   ${height}=   Split String   ${RESOLUTION}   x
   # Set Window Size   ${width}   ${height}
   Set Global Variable    ${URL}
   RETURN   ${URL}

Create edge browser
   [Arguments]   ${BROWSER}
   ${URL}=   readProperty.get_main_url   ${ENVIRONMENT}
   ${chrome_options}=   Evaluate   sys.modules['selenium.webdriver'].EdgeOptions()   sys, selenium.webdriver
   Call Method   ${options}   add_argument   --no-sandbox
   # Call Method   ${options}   add_argument   --headless  
   Call Method   ${options}   add_argument   --disable-gpu
   Call Method   ${options}   add_argument   --disable-infobars
   Call Method   ${options}   add_argument   --disable-extensions
   Call Method   ${options}   add_argument   --disable-dev-shm-usage
   Open Browser   ${URL}   browser=${BROWSER}   options=${chrome_options}
   ${width}   ${height}=   Split String   ${RESOLUTION}   x
   Set Window Size   ${width}   ${height}
   Set Global Variable    ${URL}
   RETURN   ${URL}
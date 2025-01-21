*** Settings ***
Resource    ../step-definition/frontend/home.steps.robot
# Suite Setup    Open BookingApp
# Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot
# Suite Teardown    Close All Browsers

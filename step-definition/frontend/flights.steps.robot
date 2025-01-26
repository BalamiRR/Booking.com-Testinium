*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    XML
Resource    home.steps.robot
Resource    pages/webdrivers.robot
Variables    webelements.py

*** Keywords ***
I click on the destination field where I want to go
    Log    message
I enter "I" "S" in the "Where from?" field
    Log    message
I should see a list of destinations matching the input
    Log    message
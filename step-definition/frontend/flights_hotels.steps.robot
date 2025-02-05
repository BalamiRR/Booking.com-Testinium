*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Resource    home.steps.robot
Resource    pages/webdrivers.robot
Variables    webelements.py

*** Variables ***

*** Keywords ***
I am redirected to the Flights and Hotel page  
    Log    message

I click on the departure field  
    Log    message

I see that the field is ready for input 
    Log    message

I enter at least one letter 
    Log    message

I see related cities or airports as suggestions
    Log    message

I select a random departure from the list
    Log    message
    
The departure will be assigned to the departure field
    Log    message
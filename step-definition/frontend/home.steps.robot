*** Settings ***
Library    SeleniumLibrary
Variables    webelements.py
Resource    pages/webdrivers.robot
Resource    pages/bookingHomePage.robot

*** Keywords ***
Open BookingApp
    ${URL} =
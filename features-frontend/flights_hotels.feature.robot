*** Settings ***
Resource    ../step-definition/frontend/flights_hotels.steps.robot
Resource    ../step-definition/frontend/stays.steps.robot
Force Tags    UC-FLIGHTS-HOTELS
Suite Setup    Open BookingApp
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot
Suite Teardown    Close All Browsers

*** Test Cases ***
Scenario: Searching for the departure field
    [Documentation]
     ...    Verify the functionality of the departure input field on the Flights and Hotel page.
     ...    Ensures that users can click on the departure field and see it ready for input.
     ...    enter at least one letter, relevant city or airport suggestions appear.
    [Tags]    High
    Given I will be redirected to the Flight and Hotel page
    And I select the english language on the top
    When I click on the departure field
    Then I see that the departure field is active
    When I enter at least one letter "O"
    Then I see related cities or airports as suggestions

Scenario: Assign a new departure to a departure field
    [Documentation]
     ...    Select a departure randomly from the item proposed in the list
     ...    Ensure that the new departure is assigned to the departure field 
    [Tags]    Medium
    Given I select a random departure from the list
    Then The departure will be assigned to the departure field

Scenario: Searching for the destination field
    [Documentation]
     ...    Verify the functionality of the destination input field on the Flights and Hotel page.
     ...    Ensures that users can click on the destination field and see it ready for input.
     ...    enter at least one letter, relevant city or airport suggestions appear.
    [Tags]    High
    When I click on the destination field
    Then I see that the destination field is active
    When I enter a letter "I"
    Then I see related cities or airports for destination

Scenario: Assign a new destination to a destination field
    [Documentation]
     ...    Select a destination randomly from the item proposed in the list
     ...    Ensure that the new destination is assigned to the destination field 
    [Tags]    Medium
    Given I select a random destination for hotels and flights from the list
    Then I will see that destination will be assigned to the destination field

Scenario: Clear button for departure and destination
    [Documentation]
     ...    Verify that clearing the departure or destination field works correctly.  
    [Tags]    Medium
    When I click the clear button for the departure field
    Then The departure field input is cleared  
    When I click the clear button for the destination field
    Then The destination field input is cleared

Scenario: Verify Default Check-in and out Date in the Date picker
    [Documentation]    
     ...    Verify that the date picker appears when accessing the Date field, 
     ...    with the current date selected by Default
    [Tags]    Medium
    Given I click on the calender button
    Then I see the selected dates by default

Scenario: Adding number of travallers and flight class
    [Documentation]    
     ...    This scenario verifies the functionality of selecting the number of
     ...    travellers and choosing the flight class on Booking.com. It ensures that the user
     ...    can accurately specify the number of adults, children, and infants, as well as 
     ...    select the desired flight class e.g., Economy, Premium Economy, Business, or First Class
    [Tags]    Medium
    Given I click on travallers and flights class button 
    When I will see the default number of "2" travellers, "1" room, and "Any class" class displayed
    Then I will see adults "-" and "+" buttons are enabled
    And I will see the any class option is selected as default

Scenario: Adding a child and selecting a random child age
    [Documentation]    
     ...    This scenario verifies that a child can be added successfully and a 
     ...    random age can be selected from the available options up to 12 years.
    [Tags]    Low
    Given I click on the "Add a child" option
    Then I will see the list of ages til 12 years
    When I select a random age for the child from the list
    Then I will see the newly added child's age displayed

Scenario: Adding a new room
    [Documentation]    
     ...    This scenario verifies that a new room can be added successfully 
     ...    and appears next to the first room.
    [Tags]    Low
    Given I click on the "Add a Room" button
    Then I should see the newly added room displayed next to the first one

Scenario: Verify that the popular cities are displayed correctly in the destination list
    [Documentation]    Verify that the popular cities are displayed correctly in the destination list
    [Tags]    High
    Given I click on the destination field
    Then I will see the popular cities contain "Amsterdam Netherlands" "Tenerife Canary Islands" "Dubai United Arab Emirates" "New York - Manhattan United States" "Barcelona Spain" "Lanzarote Canary Islands" "Paris France" "Prague Czech Republic" "Rome Italy" "Antalya region Turkey" 

Scenario: Search for available flights and hotels 
    [Documentation]    
    ...    This scenario verifies the search functionality for flights and hotels. 
    ...    It ensures that users can select a departure location by entering at least
    ...    one letter, choose a destination for both flights and hotels, and see the
    ...    selected values assigned correctly to the respective fields.  
    [Tags]    Medium  
    Given I click on the search button
    Then I will see mandatory fields
    When I select a random destionation and destination city
    Then I will be redirected to the flight search results page

Scenario: Search for a hotel with a star rating higher than 3
    [Documentation]    Verify that the user can randomly select hotels with more than 3 stars and navigate to the details page.
    [Tags]    High
    Given I see at least "20" hotels listed by default
    When I click the "All Filters" button at the top
    Then I should see the filters menu displayed

Scenario: Filling the required fields in the All Filters drawer
    [Documentation]    Verify that the user can randomly select hotels with more than 3 stars and navigate to the details page.
    [Tags]    Low
    Given I will see the headers "Deals" "Budget" "Flight" "Property type" "Property name" "Stars" "Meal plan" "Guest rating" "Facilities" "Area" "Nearest station" "Hotel chain" "Property style"
    When I click on the radio button for "Flash Sales"
    Then I should see the radio button turn on
    When I click on the radio button for "Flash Sales" again
    Then I will see the radio button turn off

Scenario: Hovering over the minimum budget 
    [Documentation]    
     ...    Verify that when a user hovers over the minimum budget slider 
     ...    and sets it to a specific amount (e.g., 700 pounds), 
     ...    the displayed minimum value updates accordingly
    [Tags]    Low
    When I hover over the minimum budget slider and set it to 700 pounds
    Then I should see the minimum value set to 700

Scenario: Selecting a hotel with a rating higher than 3 stars
    [Documentation]       
     ...    Ensure that when a user selects a hotel with a rating of 3 stars or higher,  
     ...    they are correctly redirected to the hotel's details page.  
     ...    On the details page, they should be able to view the hotel's name,  
     ...    price, and available booking options.
    [Tags]    Low
    Given I select the 3-star option from the Stars filter
    Then I should see the selected checkbox

Scenario: Selecting a meal plan option 
    [Documentation]    
     ...    Validate that when a user selects a specific meal plan option,  
     ...    the selection is displayed correctly.  
     ...    Additionally, when they click the "Apply" button,  
     ...    they should be redirected to the flight search results page.  
    [Tags]    Low
    When I select the "Random only" option for the meal plan
    Then I should see the "Random only" option selected
    When I click the "Apply" button
    Then I will be redirected to the hotels result page

Scenario: Selecting a random hotel
    [Documentation]
     ...    Verify that when a user selects a random hotel from the search results,  
     ...    they are redirected to the hotel's details page.  
     ...    The details page should provide information such as the hotel's name,  
     ...    pricing, amenities, and booking options.
    [Tags]    High
    Given I select a random hotel
    Then I will be redirected to the hotel details page
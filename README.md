 # :fallen_leaf: :leaves: Testinium-BookingApp :leaves: :fallen_leaf:

## 📌 Project Description
This project automates the testing process for the https://www.Booking.com site using **Python**, **Robot Framework** and **Cucumber (BDD)**. The automation suite is integrated with **Gitlab Actions CI/CD** for continuous testing and runs in an isolated **Docker** environment. Test case management and reporting are handled via **Jira Xray**.


## 🎯 Objectives
- Automate functional and regression testing
- Reduce manual testing effort and execution time
- Enable early bug detection and faster feedback loops
- Integrate automated tests into CI/CD pipeline
- Manage test cases and reports efficiently with **Jira Xray**


## 🛠️ Tech Stack

<p align="left"> 
<a href="https://www.python.org/" target="_blank" rel="noreferrer"> 
    <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/python/python-original.svg" alt="Python" width="60" height="60"/> 
</a> 

<a href="https://robotframework.org/" target="_blank" rel="noreferrer">
    <img src="https://upload.wikimedia.org/wikipedia/commons/e/e4/Robot-framework-logo.png" alt="Robot Framework" width="70" height="70"/> 
</a>    

<a href="https://www.oracle.com/" target="_blank" rel="noreferrer"> 
  <img src="https://lisacrispin.com/wp-content/uploads/2019/01/Screen-Shot-2019-01-17-at-12.13.33-PM.png" alt="oracle" width="60" height="60"/> 
</a>

<a href="https://about.gitlab.com/" target="_blank" rel="noreferrer">
    <img src="https://upload.wikimedia.org/wikipedia/commons/3/35/GitLab_icon.svg" alt="GitLab" width="50" height="50"/> 
</a>

<a href="https://www.docker.com/" target="_blank" rel="noreferrer">
    <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/docker/docker-original.svg" alt="Docker" width="70" height="70"/> 
</a> 

<a href="https://projectfactory.randstaddigital.fr/secure/AboutPage.jspa" target="_blank" rel="noreferrer">
    <img src="https://projectfactory.randstaddigital.fr/images/atlassian-jira-logo-large.png" alt="Atlassian" width="100" height="50"/> 
</a>

<a href="https://www.getxray.app/" target="_blank" rel="noreferrer">
    <img src="https://raw.githubusercontent.com/gilbarbara/logos/master/logos/xray-for-jira.svg" alt="Jira Xray" width="100" height="50"/> 
</a>

</p>

- **Programming Language:** Python
- **Test Framework:** Robot Framework
- **Behavior-Driven Development (BDD):** Cucumber (Gherkin syntax)
- **Continuous Integration & Deployment (CI/CD):** Gitlab
- **Containerization:** Docker
- **Test Management:** Jira & Xray


## 🚀 How to Run the Tests
### 1️⃣ Clone the repository
```bash
git clone https://github.com/your-username/booking-automation.git
cd booking-automation
```
##### Manually :

Fork / Clone repository from [here](https://github.com/BalamiRR/Testinium-Booking.git) or download zip and set
it up in your local workspace.

### 2️⃣ Install dependencies
```bash
pip install -r requirements.txt
```
### 3️⃣ Run tests locally
```bash
> robot --outputdir results --variable BROWSER:chrome --variable ENVIRONMENT:DEV features-frontend/stays.feature.robot
```
###  Develop automation scripts using BDD approach
Develop automation scripts using the BDD approach in Robot Framework.
There are already many predefined keywords which are packaged under /step_definition/frontend/stays.steps.robot, helping speed up your automation development with essential workaday helper methods.

Tests are written using the Robot Framework with the Gherkin Syntax. Here is one of the scenarios:
Feature File (Python Robot Framework)

##### Feature File (stays.feature.robot)
The feature file defines the test cases using the Gherkin syntax in Behavior-Driven Development (BDD). It describes scenarios in a human-readable format, ensuring clarity for both technical and non-technical stakeholders.

Here is the feature file for UC-STAYS, where we define the test cases:
```
*** Settings ***
Resource    ../step-definition/frontend/flights_hotels.steps.robot
Force Tags    UC-FLIGHTS-HOTELS

*** Test Cases ***
Scenario: Searching for the destination field
    [Documentation]
     ...    Verify the functionality of the destination input field on the Flights and Hotel page.
     ...    Ensures that users can click on the destination field and see it ready for input.
     ...    enter at least one letter, relevant city or airport suggestions appear.
    [Tags]    DEV
    When I click on the destination field
    Then I see that the destination field is active
    When I enter a letter "I"
    Then I see related cities or airports for destination
    
Scenario: Select a random age needed for children
    [Documentation]    
    ...    This scenario verifies that when the "+" button for children is clicked, the number
    ...    of children increases by 1 and the "Age needed" field appears.
    [Tags]    Medium
    Given I click the "Age needed" field
    Then I will see the list of ages 
    When I select a random age from the list
    Then The age will be assigned to the field
    When I click the Done button
    Then I see the selected number of "1" is displayed in the field
```
##### Step Definitions (flights_hotels.steps.robot)
The Step Definitions file connects the feature file’s Gherkin steps to actual automation code, enabling test execution.

Here’s an example Step Definition file :
```
*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Resource    home.steps.robot
Resource    pages/webdrivers.robot
Variables    webelements.py

*** Keywords ***

I click on the destination field
    Click Element    ${DESTINATION_FLIGHT_HOTEL_FIELD}

I will see the popular cities contain "${Amsterdam Netherlands}" "${Tenerife Canary Islands}" "${Dubai United Arab Emirates}" "${New York - Manhattan United States}" "${Barcelona Spain}" "${Lanzarote Canary Islands}" "${Paris France}" "${Prague Czech Republic}" "${Rome Italy}" "${Antalya region Turkey}" 
    ${destination_list}=    Create List    ${Amsterdam Netherlands}    ${Tenerife Canary Islands}     ${Dubai United Arab Emirates}    
    ...    ${New York - Manhattan United States}    ${Barcelona Spain}    ${Lanzarote Canary Islands}    ${Paris France}    
    ...    ${Prague Czech Republic}    ${Rome Italy}    ${Antalya region Turkey}     
    Wait Until Page Contains Element    ${LIST_OF_DESTINATION}    20s
    ${list_destination_count}    Get Element Count    ${LIST_OF_DESTINATION}
    ${list_destination_count}    Convert To Integer    ${list_destination_count}     
    ${list_number}    Convert To String    ${list_destination_count}   
    FOR    ${index}    IN RANGE    1    ${list_destination_count}
        ${random_destination_list_text}    Get Text    //ul[@class='d-1ip0gkj']//li[@id='listbox-option-${index}']
        ${random_destination_list_text}    Replace String    ${random_destination_list_text}    \n    ${SPACE}
        List Should Contain Value    ${destination_list}    ${random_destination_list_text}
    END
```

### 📌 GitLab Pipeline Execution Summary
In our GitLab CI/CD pipeline, we regularly run automated tests to ensure software quality. In this process, we encountered two different test execution outcomes:

#### 🔴 Failed Pipeline Execution
* In the first execution, 10 out of 13 tests passed, while 3 tests failed.
* The failed tests indicate potential system issues or missing functionalities.
* Test Report Screenshot:

![alt text](./image/Failed.png)
* This report provides insights into which tests failed and detailed error logs for further analysis.

#### ✅Successful Pipeline Execution
* After fixing the identified issues, all tests passed (13/13).
* This confirms that the fixes were effective and the system is functioning as expected.
* Test Report Screenshot:

![alt text](./image/Passed.png)

#### GitLab Pipeline Result
* Successful pipeline execution screenshot:
* This shows that the tests were executed successfully within the GitLab pipeline and passed the sanity frontend stage.
![alt text](./image/Pipeline.png)

### 📌Jira Xray 

#### Test Plan and Test Execution Overview
We track our test execution results using Jira Xray, ensuring better test management and defect tracking.  **Test Plan** is created to manage the testing process. The Test Plan includes the test scenarios that need to be executed, and these are run through the **Test Execution** process.
![alt text](./image/TestPlanAndExecution.png)
In this example, there are 28 tests in total, out of which 22 have passed and 6 are still to be executed. Each test case has details like the assignee, number of executions, dataset used, and the latest status.

#### 📌Test Case
The image shows a detailed test case written in Cucumber (Gherkin) format. This test verifies that users can correctly select the number of travelers and choose the appropriate flight class on the booking platform.
![alt text](./image/TestCase.png)


## 📄 License
This project is licensed under the MIT License.


# FUAT AND FURKAN KARA

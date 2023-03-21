*** Settings ***
Documentation  S1020 - User unable to login with invalid credentials.
Library  AppiumLibrary
Library  Dialogs
Resource  ../Resource/Android_Variables.robot
Resource  ../Resource/Android_Keywords.robot
Suite Setup  Open Serenity App
Suite Teardown  Close All Applications

*** Variables ***
${WRONG_PASSWORD}=  1234567

*** Test Cases ***
User Login With Invalid Credentials
    [Tags]  S1020  CRITICAL  LOGIN
    Login With Credentials  ${DEMO_ACCOUNT}  ${WRONG_PASSWORD}
    Log To Console  Invalid popup should appear
    Wait Until Element Is Visible  //*[@content-desc="Failed to login"]
    Sleep  5
    [Teardown]  Run Keyword If Test Failed  Catch Generic Info If Fail

*** Keywords ***
Catch Generic Info If Fail
    Log To Console  Test failed. Executing failure teardown
    Log  Account: ${DEMO_ACCOUNT}, Password: ${WRONG_PASSWORD}
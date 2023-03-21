*** Settings ***
Documentation  S1010 - User able to login.
Library  AppiumLibrary
Library  Dialogs
Resource  ../Resource/Android_Variables.robot
Resource  ../Resource/Android_Keywords.robot
Suite Setup  Open Serenity App
Suite Teardown  Close All Applications

*** Test Cases ***
User Login With Valid Credentials
    [Tags]  S1010  CRITICAL  LOGIN
    Login With Credentials  ${DEMO_ACCOUNT}  ${DEMO_PASSWORD}
    Log To Console  Waiting for "Work Logs" to be displayed
    Wait Until Element Is Visible  ${WORK_LOG_TEXT}
    Sleep  5
    Logout Account
    [Teardown]  Run Keyword If Test Failed  Catch Generic Info If Fail

*** Keywords ***
Catch Generic Info If Fail
    Log To Console  Test failed. Executing failure teardown
    Log  Account: ${DEMO_ACCOUNT}, Password: ${DEMO_PASSWORD}
*** Settings ***
Documentation  S2010 - User able to search work log
Library  AppiumLibrary
Library  String
Resource  ../Resource/Android_Variables.robot
Resource  ../Resource/Android_Keywords.robot
Suite Setup  Open Serenity App
Suite Teardown  Close All Applications

*** Variables ***
${WORK_LOG_NAME}=  Add work log automated UI test
${PROJECT}=  SwiftHR

*** Test Cases ***
User Able To Search Work Log
    [Tags]  S2010  HIGH  SEARCH_WORK_LOG  WORK_LOG
    Login With Credentials  ${DEMO_ACCOUNT}  ${DEMO_PASSWORD}
    Search Work Log
    [Teardown]  Run Keyword If Test Failed  Catch Generic Info If Fail

*** Keywords ***
Search Work Log
    Log To Console  Search work log
    Wait Then Click Element  ${WORK_LOG_TEXT}/preceding-sibling::*
    Sleep  5
    Wait Then Click Element  //android.view.View[@content-desc="Project:"]/following-sibling::android.widget.Button[1]
    Wait Then Click Element  //android.view.View[@content-desc="${PROJECT}"]
    Swipe  170  1500  170  1200
    Wait Then Click Element  //android.view.View[@content-desc="dd/mm/yyyy"][1]
    Wait Then Click Element  //android.view.View[@content-desc="20, Monday, March 20, 2023"]
    Sleep  5
    Wait Then Click Element  //android.view.View[@content-desc="21, Tuesday, March 21, 2023"]
    Wait Then Click Element  //android.widget.Button[@content-desc="SAVE"]
    Sleep  3
    Press Keycode  4
    Sleep  5
    Wait Until Element Is Visible  //*[contains(@content-desc, "${PROJECT}") and contains(@content-desc, "3541") and contains(@content-desc, "Implemented feature")]
    Sleep  5

Catch Generic Info If Fail
    Log To Console  Test failed. Executing failure teardown
    Log  Account: ${DEMO_ACCOUNT}, Password: ${DEMO_PASSWORD}
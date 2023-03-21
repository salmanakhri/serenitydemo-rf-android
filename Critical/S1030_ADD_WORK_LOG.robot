*** Settings ***
Documentation  S1030 - User able to add work log.
Library  AppiumLibrary
Library  String
Resource  ../Resource/Android_Variables.robot
Resource  ../Resource/Android_Keywords.robot
Suite Setup  Open Serenity App
Suite Teardown  Close All Applications

*** Variables ***
${WORK_LOG_NAME}=  Add work log automated UI test
${ACTIVE_WORK_TEXT_ELEMENT}=  //android.view.View[@content-desc="Active Works"]
${TODAY_TEXT_ELEMENT}=  //android.view.View[contains(@content-desc, "Today")]
${WORK_LOG_DETAILS}=  ${TODAY_TEXT_ELEMENT}/following-sibling::*/*[contains(@content-desc, "${WORK_LOG}")]

*** Test Cases ***
User Able To Add Work Log
    [Tags]  S1030  CRITICAL  ADD_WORK_LOG  WORK_LOG
    Login With Credentials  ${DEMO_ACCOUNT}  ${DEMO_PASSWORD}
    Add Work Log
    Stop Work Log
    Delete Work Log
    [Teardown]  Run Keyword If Test Failed  Catch Generic Info If Fail

*** Keywords ***
Add Work Log
    Log To Console  Adding work log with datetime
    Wait Then Click Element  ${ADD_BUTTON}
    Wait Then Click Element  //*[@content-desc="LogiPack"]
    Wait Then Click Element  //*[@content-desc="#9812"]
    Get Current Datetime
    ${WORK_LOG}=  Set Variable  ${WORK_LOG_NAME}_${Time}
    Set Suite Variable  ${WORK_LOG}
    Wait Then Input Text  //*[contains(@text, 'Description')]  ${WORK_LOG}
    Wait Then Click Element  ${SAVE_BUTTON}
    Log To Console  Work log should appear under "Active"
    Wait Until Element Is Visible  ${ACTIVE_WORK_TEXT_ELEMENT}/following-sibling::*/*[contains(@content-desc, "${WORK_LOG}")]  10
    Sleep  5

Stop Work Log
    Log To Console  Stopping work log
    Wait Then Click At Coordinates  ${ACTIVE_WORK_TEXT_ELEMENT}/following-sibling::*/*[contains(@content-desc, "${WORK_LOG}")]  980  560
    Sleep  5
    Log To Console  Work no longer under "Active", but under "Today"
    Wait Until Element Is Visible  ${WORK_LOG_DETAILS}  15
    Sleep  5

Delete Work Log
    Log To Console  Deleting work log
    Long Press On Element  ${WORK_LOG_DETAILS}
    Wait Then Click Element  //*[@content-desc = "Delete"]
    Wait Then Click Element  //*[@content-desc = "Yes"]
    Sleep  5
    Wait Until Page Does Not Contain Element  ${WORK_LOG_DETAILS}  10
    Sleep  5

Catch Generic Info If Fail
    Log To Console  Test failed. Executing failure teardown
    Log  Account: ${DEMO_ACCOUNT}, Password: ${DEMO_PASSWORD}
    Run Keyword And Ignore Error  Delete Work Log
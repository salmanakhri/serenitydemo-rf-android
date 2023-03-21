*** Settings ***
Documentation  S1040 - User able to edit work log.
Library  AppiumLibrary
Library  String
Resource  ../Resource/Android_Variables.robot
Resource  ../Resource/Android_Keywords.robot
Suite Setup  Open Serenity App
Suite Teardown  Close All Applications

*** Variables ***
${WORK_LOG_NAME}=  Edit work log automated UI test
${WORK_LOG_SECTION}=  //*[contains(@content-desc, "${WORK_LOG_NAME}")]
${WORK_LOG_TEXT_BUTTONS}=  ${DESCRIPTION_TEXT}/following-sibling::android.view.View
${END_TIME_BUTTON}=  ${DESCRIPTION_TEXT}/following-sibling::android.widget.Button[6]
${PROJECT_NAMES}=  //*[contains(@text, "Project")]/following-sibling::android.view.View
${ADDED_TAGS}=  //*[contains(@text, "Add tag")]
${DELETE_TAG_BUTTON}=  ${ADDED_TAGS}/android.widget.Button
${TAGS}=  ${ADDED_TAGS}/following-sibling::android.view.View
${CONTENT_DESC}=  content-desc

*** Test Cases ***
User Able To Edit Work Log
    [Tags]  S1040  CRITICAL  EDIT_WORK_LOG  WORK_LOG
    Login With Credentials  ${DEMO_ACCOUNT}  ${DEMO_PASSWORD}
    Edit Work Log
    [Teardown]  Run Keyword If Test Failed  Catch Generic Info If Fail

*** Keywords ***
Edit Work Log
    Log To Console  Editing work log
    Wait Until Element Is Visible  ${WORK_LOG_SECTION}  15
    Long Press On Element  ${WORK_LOG_SECTION}
    Wait Then Click Element  //*[@content-desc = "Edit"]
    Get Current Datetime
    ${updated_work_log_name}=  Set Variable  Edit work log automated UI test_${Time}
    Wait Then Input Text  ${DESCRIPTION_TEXT}  ${updated_work_log_name}
    Wait Then Click Element  ${WORK_LOG_TEXT_BUTTONS}\[1\]
    Sleep  5
    Wait Until Element Is Visible  ${PROJECT_NAMES}
    ${total_projects}=  Get Matching Xpath Count  ${PROJECT_NAMES}
    ${index}=  Choose Random Number  ${total_projects}
    ${PROJECT_NAME}=  Get Element Attribute  ${PROJECT_NAMES}\[${index}\]  ${CONTENT_DESC}
    Set Suite Variable  ${PROJECT_NAME}
    Wait Then Click Element  ${PROJECT_NAMES}\[${index}\]
    Wait Then Click Element  ${WORK_LOG_TEXT_BUTTONS}\[2\]
    Sleep  5
    Wait Until Element Is Visible  ${TAGS}
    Wait Then Click Element  ${DELETE_TAG_BUTTON}
    ${total_tags}=  Get Matching Xpath Count  ${TAGS}
    ${index}=  Choose Random Number  ${total_projects}
    ${TAG_NAME}=  Get Element Attribute  ${TAGS}\[${index}\]  ${CONTENT_DESC}
    Set Suite Variable  ${TAG_NAME}
    Wait Then Click Element  ${TAGS}\[${index}\]
    Press Keycode  4
    Wait Until Element Is Visible  ${END_TIME_BUTTON}
    ${end_time}=  Get Element Attribute  ${END_TIME_BUTTON}  ${CONTENT_DESC}
    ${hour_and_minute}=  Split String  ${end_time}  :
    Wait Then Click Element  ${END_TIME_BUTTON}
    Wait Until Element Is Visible  //*[contains(@content-desc, "Select minutes ${hour_and_minute}[1]")]
    Wait Then Click Element  //*[contains(@content-desc, "Select minutes ${hour_and_minute}[1]")]
    Run Keyword If  "${hour_and_minute}[1]" == "05"  Click Element At Coordinates  766  913  ELSE  Click Element At Coordinates  670  819
    ${duration}=  Set Variable If  "${hour_and_minute}[1]" == "05"  10  5  
    Wait Then Click Element  //android.widget.Button[@content-desc="OK"]
    Wait Until Element Is Visible  //*[contains(@content-desc, "Edit Work Log")]/android.view.View[@content-desc="(${duration} mins)"]
    Wait Then Click Element  ${SAVE_BUTTON}
    Wait Until Element Is Visible  //*[contains(@content-desc, "${PROJECT_NAME}") and contains(@content-desc, "${TAG_NAME}") and contains(@content-desc, "${updated_work_log_name}")]
    Sleep  5

Choose Random Number
    [Arguments]  ${highest_number}
    ${random_number_list}=  Evaluate  random.sample(range(1, ${highest_number}),1)  random
    ${random_number}=  Set Variable  ${random_number_list}[0]
    [RETURN]  ${random_number}

Catch Generic Info If Fail
    Log To Console  Test failed. Executing failure teardown
    Log  Account: ${DEMO_ACCOUNT}, Password: ${DEMO_PASSWORD}
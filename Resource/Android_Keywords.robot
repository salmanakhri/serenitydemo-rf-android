*** Keywords ***
########## SUITE SETUP ##########
Open Serenity App
    [Arguments]  ${Country_Selection}=${Country_Malaysia}  ${Android_Language}=en  ${Android_Country}=US
    Set Library Search Order  AppiumLibrary  # Change the working library to Appium
    Open Serenity Startup  ${Android_Language}  ${Android_Country}  
    Wait Until Element Is Visible  ${Login_Email_Field}  25

Open Serenity Startup
    [Arguments]  ${Android_Language}  ${Android_Country}
    Open Application  http://localhost:${APPIUMSERVERPORT}/wd/hub 	alias=PBApp
        ...  platformName=${PLATFORM_NAME} 	platformVersion=${PLATFORM_VERSION}  deviceName=${DEVICE_NAME}
        ...  udid=${DEVICE_UDID}  automationName=${UiAutomator2}  appPackage=${APP_PACKAGE}  appActivity=${APP_ACTIVITY}
        ...  autoGrantPermissions=true  avd=${AVD_NAME}  avdArgs=${AVD_WINDOW}  adbExecTimeout=1000000  disableWindowAnimation=true
        ...  newCommandTimeout=3000  disableAndroidWatchers=true  skipDeviceInitialization=true  autoWebviewTimeout=20000
        ...  language=${Android_Language}  locale=${Android_Country}

########## SUITE TEARDOWN ##########
Close All Browsers And Apps
    Close All Browsers
    Close All Applications

##########  USER DEFINED KEYWORDS ##########
Long Press On Element
# Swipe from a single coordinate to another single coordinate in 2 seconds, to emulate tap and hold.
# Get the coordinate of the element (top-left most) and it's size.
# Add a 100 to both x and y coordinate as swipe start point.
# Add a single digit to y coordinate to emulate a very slow swipe within 2 seconds.
    [Arguments]  ${element}
    ${element_location}=  Get Element Location  ${element}
    Log To Console  Element location: ${element_location}
    ${element_size}=  Get Element Size  ${element}
    Log To Console  Element size: ${element_size}
    ${str_element_location}=  Convert To String  ${element_location}
    ${str_element_size}=  Convert To String  ${element_size}
    @{element_locations}=  Split String  ${str_element_location}  separator=:${SPACE}
    @{element_sizes}=  Split String  ${str_element_size}  separator=:${SPACE}
    ${x}=  Get Substring  ${element_locations}[1]  0  -5
    ${y}=  Get Substring  ${element_locations}[2]  0  -1
    ${x_offset}=  Get Substring  ${element_sizes}[2]  0  -1
    ${y_offset}=  Get Substring  ${element_sizes}[1]  0  -9
    Log To Console  X: ${x}
    Log To Console  Y: ${y}
    Log To Console  X_offset: ${x_offset}
    Log To Console  Y_offset: ${y_offset}
    ${max_x}=  Evaluate  ${x}+100
    ${max_y}=  Evaluate  ${y}+100
    Log To Console  Max X: ${max_x}
    Log To Console  Max Y: ${max_y}
    ${swipe_length}=  Evaluate  ${max_y}+1
    Swipe  ${max_x}  ${max_y}  ${max_x}  ${swipe_length}  2000

Login With Credentials
    [Arguments]  ${account}  ${password}
    Log To Console  Entering credentials
    Enter Login Credentials  ${account}  ${password}

Enter Login Credentials
    [Arguments]  ${account}  ${password}
    Wait Then Input Text  ${Login_Email_Field}  ${account}  40
    Wait Then Click Element  ${Login_Pass_Field}
    Sleep  5
    Wait Then Click Element  ${Login_Pass_Field}
    Wait Then Input Text  ${Login_Pass_Field}  ${password}
    Wait Then Click Element  ${Login_Submit_Btn}

Get Current Datetime
    Import Library  DateTime
    ${Time}=  Get Current Date  result_format=${Date_Format}
    Set Suite Variable  ${Time}

Logout Account 
    Log To Console  Logging out
    Wait Then Click Element  //*[contains(@content-desc, "Settings")]
    Wait Then Click Element  //*[@content-desc = "Logout"]
    Wait Until Element Is Visible  ${Login_Email_Field}
    Sleep  5

########## ESSENTIAL KEYWORDS ##########
Wait Then Click Element
    [Arguments]  ${html_element}  ${timeout}=${Default_Timeout}
    Wait Until Element Is Visible  ${html_element}  timeout=${timeout}
    ${status}=  Run Keyword And Return Status  Click Element  ${html_element}
    Run Keyword If  '${status}' == 'False'  Click Element  ${html_element}

Wait Then Input Text
    [Arguments]  ${text_field}  ${input_value}  ${timeout}=${Default_Timeout}
    Wait Until Element Is Visible  ${text_field}  timeout=${timeout}
    Input Text  ${text_field}  ${input_value}

Wait Then Click At Coordinates
    [Arguments]  ${html_element}  ${offset_x}  ${offset_y}  ${timeout}=${Default_Timeout}
    Wait Until Element Is Visible  ${html_element}  timeout=${timeout}
    Click Element At Coordinates  ${offset_x}  ${offset_y}
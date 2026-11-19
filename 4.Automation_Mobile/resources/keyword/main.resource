*** Settings ***
Documentation    Reusable Minimal-Todo Android keywords (Robot Framework + AppiumLibrary).
Resource    ${CURDIR}/../../settings/import.resource

*** Keywords ***
Open Minimal Todo Application
    [Documentation]    Create a session against the installed Minimal-Todo APK.
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    appium:options=&{APPIUM_OPTIONS}
    Set Appium Timeout    ${DEFAULT_TIMEOUT}s
    # A previous case may leave the IME open over the bottom FAB.
    Run Keyword And Ignore Error    Hide Keyboard
    Wait Until Page Contains Element    ${SELECTOR["add_task_fab"]}    20s

Close Minimal Todo Application
    [Documentation]    Close the Appium session at the end of each test.
    Run Keyword And Ignore Error    Hide Keyboard
    Run Keyword And Ignore Error    Close Application

Restart Minimal Todo Application
    [Documentation]    Background the app first to allow lifecycle callbacks, then relaunch in the same Appium session.
    # HOME causes onPause/onStop and allows pending persistence operations to complete.
    Press Keycode    3
    Sleep    1s
    Terminate Application    ${APP_PACKAGE}
    Activate Application    ${APP_PACKAGE}
    Wait Until Page Contains Element    ${SELECTOR["add_task_fab"]}    20s
    # Diagnostic only: keep the verification in the test case; never turn a missing item into PASS.
    ${empty}    Run Keyword And Return Status    Wait Until Page Contains Element    ${SELECTOR["empty_view"]}    1s
    IF    ${empty}
        Log    Empty-state view displayed after relaunch; check app persistence and save lifecycle.    WARN
    END

Build Unique Title
    [Documentation]    Generate a unique title short enough for the 30-character limit.
    [Arguments]    ${prefix}=QA
    ${timestamp}    Evaluate    str(__import__('time').time_ns() // 1000000)
    ${title}    Set Variable    ${prefix} ${timestamp}
    ${length}    Get Length    ${title}
    Should Be True    ${length} <= 30    msg=Generated title exceeds maximum 30 characters.
    RETURN    ${title}

Get Todo Item Locator By Title
    [Documentation]    Locate title TextView with an exact @text match.
    [Arguments]    ${title}
    ${locator}    Set Variable    xpath=//android.widget.TextView[@resource-id='${APP_PACKAGE}:id/toDoListItemTextview' and @text='${title}']
    RETURN    ${locator}

Get Todo Item Row Locator
    [Documentation]    Locate clickable parent row of the given item title.
    [Arguments]    ${title}
    ${locator}    Set Variable    xpath=//android.widget.LinearLayout[@resource-id='${APP_PACKAGE}:id/listItemLinearLayout'][.//android.widget.TextView[@text='${title}']]
    RETURN    ${locator}

Verify Empty State Displayed
    Wait Until Page Contains Element    ${SELECTOR["empty_view"]}    ${DEFAULT_TIMEOUT}s

Create New ToDo Item
    [Documentation]    Create a ToDo by title only. No Description input was found in actual XML.
    [Arguments]    ${title}
    Wait Until Page Contains Element    ${SELECTOR["add_task_fab"]}    ${DEFAULT_TIMEOUT}s
    Click Element    ${SELECTOR["add_task_fab"]}
    Wait Until Page Contains Element    ${SELECTOR["input_title"]}    ${DEFAULT_TIMEOUT}s
    Input Text    ${SELECTOR["input_title"]}    ${title}
    Click Element    ${SELECTOR["save_task_fab"]}
    Wait Until Page Contains Element    ${SELECTOR["add_task_fab"]}    ${DEFAULT_TIMEOUT}s

Verify ToDo Item Displayed
    [Arguments]    ${title}
    ${locator}    Get Todo Item Locator By Title    ${title}
    Wait Until Page Contains Element    ${locator}    ${DEFAULT_TIMEOUT}s

Verify ToDo Item Not Displayed
    [Arguments]    ${title}
    ${locator}    Get Todo Item Locator By Title    ${title}
    Wait Until Page Does Not Contain Element    ${locator}    ${DEFAULT_TIMEOUT}s

Open Existing ToDo Item
    [Arguments]    ${title}
    ${locator}    Get Todo Item Row Locator    ${title}
    Wait Until Page Contains Element    ${locator}    ${DEFAULT_TIMEOUT}s
    Click Element    ${locator}
    Wait Until Page Contains Element    ${SELECTOR["input_title"]}    ${DEFAULT_TIMEOUT}s

Update ToDo Title
    [Arguments]    ${new_title}
    Wait Until Page Contains Element    ${SELECTOR["input_title"]}    ${DEFAULT_TIMEOUT}s
    Clear Text    ${SELECTOR["input_title"]}
    Input Text    ${SELECTOR["input_title"]}    ${new_title}
    Click Element    ${SELECTOR["save_task_fab"]}
    Wait Until Page Contains Element    ${SELECTOR["add_task_fab"]}    ${DEFAULT_TIMEOUT}s

Swipe Delete ToDo Item
    [Documentation]    Swipe row immediately; do NOT wait for deletion so UNDO remains actionable.
    [Arguments]    ${title}
    ${locator}    Get Todo Item Row Locator    ${title}
    Wait Until Page Contains Element    ${locator}    ${DEFAULT_TIMEOUT}s
    ${element}    Get Webelement    ${locator}
    ${bounds}    Evaluate    $element.rect
    ${from_x}    Evaluate    int($bounds['x'] + $bounds['width'] * 0.85)
    ${to_x}    Evaluate    int($bounds['x'] + $bounds['width'] * 0.15)
    ${y}    Evaluate    int($bounds['y'] + $bounds['height'] / 2)
    # Positional arguments for the installed AppiumLibrary (log expects 4-5 args).
    Swipe    ${from_x}    ${y}    ${to_x}    ${y}    600

Click Undo Button On Snackbar
    [Documentation]    Snackbar selector must be confirmed while snackbar is visible.
    Wait Until Page Contains Element    ${SELECTOR["snackbar_undo"]}    3s
    Click Element    ${SELECTOR["snackbar_undo"]}

Verify Title Character Limit
    [Documentation]    Assert EditText truncates the value to max_length characters.
    [Arguments]    ${input_text}    ${max_length}=30
    Click Element    ${SELECTOR["add_task_fab"]}
    Wait Until Page Contains Element    ${SELECTOR["input_title"]}    ${DEFAULT_TIMEOUT}s
    Input Text    ${SELECTOR["input_title"]}    ${input_text}
    ${actual}    Get Text    ${SELECTOR["input_title"]}
    ${expected}    Evaluate    $input_text[:int($max_length)]
    Should Be Equal As Strings    ${actual}    ${expected}    msg=Observed title exceeds expected 30-character limit. Confirm product requirement and report as defect if required.

Toggle Reminder Switch And Verify
    [Documentation]    Assert the reminder switch changes and returns to its original state.
    Click Element    ${SELECTOR["add_task_fab"]}
    Wait Until Page Contains Element    ${SELECTOR["reminder_switch"]}    ${DEFAULT_TIMEOUT}s
    ${state_before}    Get Element Attribute    ${SELECTOR["reminder_switch"]}    checked
    Click Element    ${SELECTOR["reminder_switch"]}
    ${state_after}    Get Element Attribute    ${SELECTOR["reminder_switch"]}    checked
    Should Not Be Equal As Strings    ${state_before}    ${state_after}
    Click Element    ${SELECTOR["reminder_switch"]}
    ${state_restored}    Get Element Attribute    ${SELECTOR["reminder_switch"]}    checked
    Should Be Equal As Strings    ${state_before}    ${state_restored}

*** Settings ***
Documentation    Q4: Android Minimal-Todo mobile automation with Robot Framework + AppiumLibrary.
Resource    ${CURDIR}/../resources/keyword/main.resource
Test Setup    Open Minimal Todo Application
Test Teardown    Close Minimal Todo Application

*** Test Cases ***
TC-MOB-001: Create ToDo Item With Title
    [Documentation]    Verify the user can create a ToDo item with a valid title.
    ${title}    Build Unique Title    QA Create
    Create New ToDo Item    ${title}
    Verify ToDo Item Displayed    ${title}

TC-MOB-002: Edit Existing ToDo Title
    [Documentation]    Verify edited title is shown and the old title disappears.
    ${initial_title}    Build Unique Title    QA Init
    ${updated_title}    Build Unique Title    QA Updated
    Create New ToDo Item    ${initial_title}
    Open Existing ToDo Item    ${initial_title}
    Update ToDo Title    ${updated_title}
    Verify ToDo Item Displayed    ${updated_title}
    Verify ToDo Item Not Displayed    ${initial_title}

TC-MOB-003: Delete ToDo Item By Swiping
    [Documentation]    Verify a horizontally swiped ToDo item disappears.
    ${title}    Build Unique Title    QA Delete
    Create New ToDo Item    ${title}
    Swipe Delete ToDo Item    ${title}
    Verify ToDo Item Not Displayed    ${title}

TC-MOB-004: Undo Deleted ToDo Item Via Snackbar
    [Documentation]    Verify tapping UNDO restores a swiped ToDo item.
    [Tags]    needs-snackbar-locator-verification
    ${title}    Build Unique Title    QA Undo
    Create New ToDo Item    ${title}
    Swipe Delete ToDo Item    ${title}
    Click Undo Button On Snackbar
    Verify ToDo Item Displayed    ${title}

TC-MOB-005: Verify Title Character Limit To Thirty Characters
    [Documentation]    Verify the title field enforces its 30-character limit.
    Verify Title Character Limit    ${TEST_DATA["long_title"]}    ${TEST_DATA["max_title_length"]}

TC-MOB-006: Toggle Reminder Switch State
    [Documentation]    Verify reminder switch toggles on and back off.
    Toggle Reminder Switch And Verify

TC-MOB-007: Verify Data Persistence Across App Relaunch
    [Documentation]    Verify saved ToDo survives terminating and relaunching the app.
    ${title}    Build Unique Title    QA Persist
    Create New ToDo Item    ${title}
    Verify ToDo Item Displayed    ${title}
    Restart Minimal Todo Application
    Verify ToDo Item Displayed    ${title}

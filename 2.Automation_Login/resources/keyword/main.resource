*** Settings ***


Resource    ${EXECDIR}/Automation/2.Automation_Login/settings/import.resource




*** Keywords ***


Initialize Browser
    [Documentation]    Open browser
    Set Browser Timeout    ${BROWSER_TIMEOUT}s
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    viewport={"width": 1290, "height": 600}
    New Page    url=${BASE_URL}    wait_until=domcontentloaded


Go To Login Page
    Go To    ${BASE_URL}${PATH_LOGIN}    wait_until=domcontentloaded
    Wait For Elements State    ${SELECTOR["form_login"]}   attached


Input Username And Password
    [Arguments]    ${login_status}=success
    Set Log Level    NONE

    Clear Text    ${SELECTOR["input_username"]}
    Clear Text    ${SELECTOR["input_password"]}

    Fill Text    ${SELECTOR["input_username"]}    ${USER["${login_status}"]["username"]}

    Get Property
        ...    ${SELECTOR["input_username"]}
        ...    value    equal
        ...    ${USER["${login_status}"]["username"]}

    Fill Secret    ${SELECTOR["input_password"]}    $USER["${login_status}"]["password"]

    Get Property
        ...    ${SELECTOR["input_password"]}
        ...    value    equal
        ...    ${USER["${login_status}"]["password"]}

    Set Log Level    INFO


Click Login Button

    ${wait_for_response}    Promise To    Wait For Response    **${PATH_AUTHEN}**

    ${button_login}    Get Element    ${SELECTOR["button_login"]}
    Click    ${button_login}

    # VAR    ${RESPONSE_AUTH}
    Set Suite Variable    ${RESPONSE_AUTH}    ${wait_for_response}


Login Success Message
    # Verify Response
    ${response}    Wait For    ${RESPONSE_AUTH}

    ${location}    Set Variable    ${response['headers']['location']}


    # Login Success Message
    # Check Login
    ${is_success}    Run Keyword And Return Status
        ...    Should Be Equal As Strings
        ...    ${location}    ${BASE_URL}${PATH_SECURE}

    IF    ${is_success}
        Get Property    ${SELECTOR["flash_messages"]}
            ...    innerText
            ...    contains
            ...    ${MESSAGE_SUCCESS}
    ELSE
        Fail    Login Failed
    END


Click Logout Button
    # Logout
    ${wait_for_response}    Promise To    Wait For Response    **${PATH_LOGOUT}**

    ${button_logout}    Get Element    ${SELECTOR["button_logout"]}
    Click    ${button_logout}

    # VAR    ${RESPONSE_LOGOUT}
    Set Suite Variable    ${RESPONSE_LOGOUT}    ${wait_for_response}

Logout Success Message
    ${response}    Wait For    ${RESPONSE_LOGOUT}

    ${location}    Set Variable    ${response['headers']['location']}

    ${is_logout}    Run Keyword And Return Status
        ...    Should Be Equal As Strings
        ...    ${location}    ${BASE_URL}${PATH_LOGIN}

    IF    ${is_logout}
        Get Property    ${SELECTOR["flash_messages"]}
            ...    innerText
            ...    contains
            ...    ${MESSAGE_LOGOUT}

    ELSE
        Fail    Logout Failed
    END


Login Failed Username Message
    ${response}    Wait For    ${RESPONSE_AUTH}

    ${location}    Set Variable    ${response['headers']['location']}

    ${is_failed}    Run Keyword And Return Status
        ...    Should Be Equal As Strings
        ...    ${location}    ${BASE_URL}${PATH_LOGIN}

    IF   ${is_failed}
        Get Property    ${SELECTOR["flash_messages"]}
            ...    innerText
            ...    contains
            ...    ${MESSAGE_USERNAME_FAILED_LOGIN}

    ELSE
        Fail     Failed
    END


Login Failed Password Message
    ${response}    Wait For    ${RESPONSE_AUTH}

    ${location}    Set Variable    ${response['headers']['location']}

    ${is_failed}    Run Keyword And Return Status
        ...    Should Be Equal As Strings
        ...    ${location}    ${BASE_URL}${PATH_LOGIN}

    IF   ${is_failed}
        Get Property    ${SELECTOR["flash_messages"]}
            ...    innerText
            ...    contains
            ...    ${MESSAGE_PASSWORD_FAILED_LOGIN}

    ELSE
        Fail     Failed
    END

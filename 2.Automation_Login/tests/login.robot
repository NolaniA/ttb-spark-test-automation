*** Settings ***


Resource    ${EXECDIR}/Automation/2.Automation_Login/resources/keyword/main.resource

*** Test Cases ***


Login Success
    [Documentation]    To verify that users can login successfully when input a correct username and password.
    Go To Login Page
    Input Username And Password    login_status=success
    Click Login Button
    Login Success Message
    Click Logout Button
    Logout Success Message

Login Failed - Password Incorrect
    [Documentation]    To verify that users can login unsuccessfully when they input a correct username but wrong password.
    Go To Login Page
    Input Username And Password    login_status=invalid_password
    Click Login Button
    Login Failed Password Message

Login Failed - Username not found
    [Documentation]    To verify that users can login unsuccessfully when they input a username that did not exist.
    Go To Login Page
    Input Username And Password    login_status=invalid_username
    Click Login Button
    Login Failed Username Message

















    # Pause Execution


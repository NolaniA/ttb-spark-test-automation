*** Comments ***
    This file contains the import settings for the mobile tests.

*** Settings ***
Documentation     Q4: Mobile automation tests for Minimal-Todo using AppiumLibrary.

Library    AppiumLibrary    run_on_failure=Capture Page Screenshot
Library    String
Library    Collections

# variable mobile
Variables    ${EXECDIR}/Automation/4.Automation_Mobile/variables/mobile/global_variable.py

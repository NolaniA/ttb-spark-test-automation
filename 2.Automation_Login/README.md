# Assignment 2: Web Automation (Login Testing)

## Problem Description
Create an automation script to test the login functionality of `http://the-internet.herokuapp.com/login` following the test cases below:

### Credentials
- **Username:** `tomsmith`
- **Password:** `SuperSecretPassword!`

### Test Cases Matrix
| Test Case Name | Objective | Test Steps | Expected Result |
| :--- | :--- | :--- | :--- |
| **Login success** | To verify that users can login successfully when input a correct username and password. | 1. Open browser and go to `http://the-internet.herokuapp.com/login`<br>2. Input username `tomsmith` and password `SuperSecretPassword!`<br>3. Click the 'Logout' button. | 1. Login page is shown.<br>2. Login success and message `'You logged into a secure area!'` is shown.<br>3. Go back to Login page and message `'You logged out of the secure area!'` is shown. |
| **Login failed - Password incorrect** | To verify that users can login unsuccessfully when they input a correct username but wrong password. | 1. Open browser and go to `http://the-internet.herokuapp.com/login`<br>2. Input username `tomsmith` and password `Password!` | 1. Login page is shown.<br>2. Login failed and message `'Your password is invalid!'` is shown. |
| **Login failed - Username not found** | To verify that users can login unsuccessfully when they input a username that did not exist. | 1. Open browser and go to `http://the-internet.herokuapp.com/login`<br>2. Input username `tomholland` and password `Password!` | 1. Login page is shown.<br>2. Login failed and message `'Your username is invalid!'` is shown. |

## Technology & Architecture
- **Framework:** Robot Framework 7.x
- **Driver / Engine:** Robot Framework Browser Library (Playwright-based)
- **Design Pattern:** Layered Keyword-Driven Architecture
  ```text
  Automation/2.Automation_Login/
  ├── settings/
  │   └── import.resource               # Centralized library and variable imports
  ├── variables/
  │   └── login/
  │       └── global_variable.py        # URLs, selectors, test credentials, flash messages
  ├── resources/
  │   └── keyword/
  │       └── main.resource             # Reusable business action keywords
  └── tests/
      ├── __init__.robot                # Suite setup/teardown (browser lifecycle)
      └── login.robot                   # Clean test case definitions
  ```

## Prerequisites
Ensure Node.js and Browser Library dependencies are initialized:
```bash
pip install robotframework-browser
rfbrowser init
```

## How to Run

Run all login tests and output results to `results/web`:
```bash
robot -d results/web Automation/2.Automation_Login/tests/login.robot
```

To run with suite initialization (handles browser opening & closing at suite level):
```bash
robot -d results/web Automation/2.Automation_Login/tests
```

# Assignment 4: Mobile Automation (Minimal-Todo)

## Problem Description
Design test coverage and create automated test scripts for an Android mobile application using **Robot Framework + Appium framework**.
- **Target Application:** Minimal-Todo ([GitHub Source](https://github.com/avjinder/Minimal-Todo))
- **Application Package:** `com.avjindersinghsekhon.minimaltodo`
- **Main Activity:** `com.example.avjindersinghsekhon.minimaltodo.Main.MainActivity`

## Test Coverage & Test Cases Design
A detailed test coverage document with 11 test scenarios is available in:
- [docs/test_cases_minimal_todo.md](docs/test_cases_minimal_todo.md)

### Automated Test Cases Summary
| Test Case ID | Test Case Name | Objective |
| :--- | :--- | :--- |
| **TC-MOB-001** | Create ToDo Item With Title And Description | Verify successful creation of a new task |
| **TC-MOB-002** | Edit Existing ToDo Title | Verify editing and updating an existing task title |
| **TC-MOB-003** | Delete ToDo Item By Swiping | Verify task removal by swiping horizontally across the item |
| **TC-MOB-004** | Undo Deleted ToDo Item Via Snackbar | Verify restoring deleted task using the UNDO action |
| **TC-MOB-005** | Verify Title Character Limit To Thirty Characters | Verify that title input is restricted to 30 characters |
| **TC-MOB-006** | Toggle Reminder Switch State | Verify toggling reminder switch changes checked state |
| **TC-MOB-007** | Verify Data Persistence Across App Relaunch | Verify tasks persist after closing and reopening the app |

## Project Architecture
```text
Automation/4.Automation_Mobile/
├── docs/
│   └── test_cases_minimal_todo.md      # Detailed test coverage & test case specification
├── settings/
│   └── import.resource                 # AppiumLibrary and variable imports
├── variables/
│   └── mobile/
│       └── global_variable.py          # Device capabilities, selectors, test data
├── resources/
│   └── keyword/
│       └── main.resource               # Reusable keywords (add, edit, swipe, undo, restart)
└── tests/
    └── minimal_todo.robot              # Robot Framework test cases
```

## Prerequisites
1. **Android Emulator / Real Device:**
   - Started and verified with `adb devices`
2. **Minimal-Todo App:**
   - Compiled APK installed on device (`adb install -r app-debug.apk`)
3. **Appium Server:**
   ```bash
   npm install -g appium
   appium driver install uiautomator2
   ```

## How to Run

1. Start Appium Server in a separate terminal:
   ```bash
   appium
   ```
2. Run the mobile test suite:
   ```bash
   robot -d results/mobile Automation/4.Automation_Mobile/tests/minimal_todo.robot
   ```

3. Dry-run mode (verifies keyword & locator syntax without device connection):
   ```bash
   robot --dryrun Automation/4.Automation_Mobile/tests/minimal_todo.robot
   ```

# TTB Spark - Test Automation Assignment

## Overview
This repository contains solutions for the TTB Spark Test Automation Assignment. It covers algorithm problem solving, Web UI automation, REST API automation, Mobile automation, CI/CD pipeline automation, and cryptography decryption.

## Technology Stack
- **Language:** Python 3.10+
- **Test Framework:** Robot Framework 7.x
- **Web Automation:** Robot Framework Browser Library (Playwright)
- **API Automation:** Robot Framework RequestsLibrary
- **Mobile Automation:** Robot Framework AppiumLibrary, Appium 2.x, UiAutomator2
- **CI/CD:** Jenkins Declarative Pipeline

## Assignment Structure

| No. | Assignment | Folder | Description | Tech Stack |
|:---:|------------|--------|-------------|------------|
| 1 | Duplicate Items | `Automation/1.Check_Duplicate/` | Find common elements between two lists without duplicates | Python |
| 2 | Web Automation | `Automation/2.Automation_Login/` | Login UI testing with positive and negative test cases | Robot Framework + Browser (Playwright) |
| 3 | API Automation | `Automation/3.Automation_Api_GET/` | REST API GET testing (Success 200 & Not Found 404) | Robot Framework + RequestsLibrary |
| 4 | Mobile Automation | `Automation/4.Automation_Mobile/` | Android Minimal-Todo test coverage & automation suite | Robot Framework + AppiumLibrary |
| 5 | Jenkins Pipeline | `Automation/5.JenkinsFile/` | Declarative CI pipeline for automated execution & reporting | Jenkins Pipeline + Robot Plugin |
| 6 | Simple Cipher | `Automation/6.Simple_Cipher/` | Caesar cipher counter-clockwise wheel decryption | Python |

## Prerequisites
- **Python 3.10+**
- **Node.js 18+** & npm (for Playwright Browser and Appium)
- **Robot Framework & Libraries:**
  ```bash
  pip install -r requirements.txt
  rfbrowser init
  ```
- **Appium Server & UiAutomator2 Driver** (for Assignment 4):
  ```bash
  npm install -g appium
  appium driver install uiautomator2
  ```
- **Android SDK and Emulator / Real Device** (for Assignment 4)
- **Jenkins** with Robot Framework Plugin (for Assignment 5)

## Test Execution

### 1. Duplicate Items (Question 1)
```bash
python Automation/1.Check_Duplicate/check_duplicate.py
```

### 2. Web Login Automation (Question 2)
```bash
robot -d results/web Automation/2.Automation_Login/tests/login.robot
```

### 3. API Automation (Question 3)
```bash
robot -d results/api Automation/3.Automation_Api_GET/get_user.robot
```

### 4. Mobile Automation (Question 4)
Ensure Android Emulator is running (`adb devices`) and Appium Server is started (`appium` on port 4723):
```bash
robot -d results/mobile Automation/4.Automation_Mobile/tests/minimal_todo.robot
```

### 5. Jenkins Pipeline (Question 5)
Configure a Jenkins pipeline job pointing to `Automation/5.JenkinsFile/Jenkinsfile`.

### 6. Simple Cipher (Question 6)
```bash
python Automation/6.Simple_Cipher/Simple_Cipher.py
```

## Test Reports
Robot Framework generates test execution artifacts automatically in the specified output directory:
- `report.html` - Summary overview report
- `log.html` - Detailed step-by-step execution log
- `output.xml` - Machine-readable XML report for CI/CD integration

For detailed instructions on each assignment, please refer to the README in each assignment directory.

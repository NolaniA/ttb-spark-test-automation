# Assignment 5: Jenkins Pipeline for Automated Script

## Problem Description
Create a Jenkins Declarative Pipeline script to automate test execution and publish test results.

## Pipeline Architecture
The pipeline consists of three core stages matching the prompt requirements:
```groovy
pipeline {
    agent { label 'any' }

    stages {
        stage('Checkout Code From Git') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/USERNAME/ttb-test.git'
            }
        }

        stage('Run Test Automate') {
            steps {
                catchError(
                    buildResult: 'UNSTABLE',
                    stageResult: 'FAILURE'
                ) {
                    bat 'python -m robot -d results tests'
                }
            }
        }

        stage('Send Result To Jenkins') {
            steps {
                robot outputPath: 'results',
                      outputFileName: 'output.xml',
                      logFileName: 'log.html',
                      reportFileName: 'report.html'
            }
        }
    }
}
```

## Stage Descriptions
1. **Checkout Code From Git:**
   Pulls the latest test code from the Git repository (GitHub / Bitbucket).
2. **Run Test Automate:**
   Executes Robot Framework automation test suites. Wrapped with `catchError` to ensure test failures mark the stage as `FAILURE` / build as `UNSTABLE` while still proceeding to result reporting.
3. **Send Result To Jenkins:**
   Uses the Jenkins **Robot Framework Plugin** step (`robot`) to parse `output.xml`, render trend graphs, and archive `report.html` and `log.html` directly onto the Jenkins job dashboard.

## Setup Requirements
1. **Jenkins Plugins:**
   - Git plugin
   - Robot Framework plugin
2. **Agent Environment:**
   - Python 3.10+ with `robotframework` installed
   - Suitable execution runner (`bat` for Windows agents, `sh` for Linux agents)

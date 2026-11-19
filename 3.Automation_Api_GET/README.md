# Assignment 3: REST API GET Automation

## Problem Description
Create an automation script using your preferred programming language to test REST API GET requests against `https://reqres.in`.

### Test Scenarios
| Test Case Name | Objective | Test Steps | Expected Result |
| :--- | :--- | :--- | :--- |
| **Get user profile success** | To verify get user profile API will return correct data when trying to get profile of an existing user. | 1. Send GET request to `https://reqres.in/api/users/12` | 1. Verify response status code is `200`<br>2. Compare response body:<br>&bull; `'ID' == 12`<br>&bull; `'Email' == rachel.howell@reqres.in`<br>&bull; `'First Name' == Rachel`<br>&bull; `'Last Name' == Howell`<br>&bull; `'Avatar' == https://reqres.in/img/faces/12-image.jpg` |
| **Get user profile but user not found** | To verify get user profile API will return 404 not found when trying to get profile of a non-existing user. | 1. Send GET request to `https://reqres.in/api/users/1234` | 1. Verify response status code is `404`<br>2. Response body should be `{}` (empty JSON object) |

## Technology
- **Framework:** Robot Framework 7.x
- **Library:** `RequestsLibrary`, `Collections`

## How to Run

```bash
robot -d results/api Automation/3.Automation_Api_GET/get_user.robot
```

## Generated Reports
- `results/api/report.html`
- `results/api/log.html`
- `results/api/output.xml`

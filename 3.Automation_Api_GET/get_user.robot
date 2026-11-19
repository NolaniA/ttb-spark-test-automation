*** Settings ***
Documentation      Q3: Positive and negative GET requests against the original ReqRes classic users endpoints.
Library            RequestsLibrary
Library            Collections
Suite Setup        Create ReqRes Session
Suite Teardown     Delete All Sessions

*** Variables ***
${BASE_URL}        https://reqres.in

*** Test Cases ***
Get User Profile Success
    ${response}    GET On Session    reqres    /api/users/12    expected_status=200
    Should Be Equal As Integers    ${response.status_code}    200
    ${payload}    Evaluate    $response.json()
    ${data}    Get From Dictionary    ${payload}    data
    Should Be Equal As Integers    ${data}[id]            12
    Should Be Equal    ${data}[email]    rachel.howell@reqres.in
    Should Be Equal    ${data}[first_name]    Rachel
    Should Be Equal    ${data}[last_name]    Howell
    Should Be Equal    ${data}[avatar]    https://reqres.in/img/faces/12-image.jpg

Get User Profile Not Found
    ${response}    GET On Session    reqres    /api/users/1234    expected_status=404
    Should Be Equal As Integers    ${response.status_code}    404
    ${payload}    Evaluate    $response.json()
    Should Be Empty    ${payload}

*** Keywords ***
Create ReqRes Session
    &{headers}    Create Dictionary    User-Agent=reqres-qa-tests/1.0    Accept=application/json
    Create Session    reqres    ${BASE_URL}    headers=${headers}    timeout=20    verify=${True}

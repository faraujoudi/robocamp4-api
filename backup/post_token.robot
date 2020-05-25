*** Settings ***
Library     Collections
Library     RequestsLibrary

*** Test Cases ***
Login na API
    Dado que o usuário informou suas credencias de acesso:
    ...     papito@ninjapixel.com       pwd123
    Quando eu faço uma solicitação POST para o serviço /auth
    Então o código de resposta deve ser igual a     200

Senha incorreta
    Dado que o usuário informou suas credencias de acesso:
    ...     papito@ninjapixel.com       abc123
    Quando eu faço uma solicitação POST para o serviço /auth
    Então o código de resposta deve ser igual a     401

***Keywords***
Dado que o usuário informou suas credencias de acesso:
    [Arguments]     ${email}        ${pass}

    &{payload}=     Create Dictionary   email=${email}     password=${pass}

    Set Test Variable       &{payload}

Quando eu faço uma solicitação POST para o serviço /auth
    Create Session      pixel       http://pixel-api:3333

    &{headers}=         Create Dictionary   Content-Type=application/json

    ${resp}=            Post Request    pixel       /auth   data=${payload}     headers=${headers}

    Set Test Variable   ${resp}

Então o código de resposta deve ser igual a
    [Arguments]     ${status_code}

    Status Should Be    ${status_code}     ${resp}

# Post Auth Token
#     Create Session      pixel       http://pixel-api:3333

#     # {email: "papito@ninjapixel.com", password: "pwd123"}
#     # Content-Type: application/json;charset=UTF-8

#     &{payload}=     Create Dictionary   email=papito@ninjapixel.com     password=pwd123
#     &{headers}=     Create Dictionary   Content-Type=application/json

#     ${resp}=            Post Request    pixel       /auth   data=${payload}     headers=${headers}
#     Status Should Be    200             ${resp}
#     Log                 ${resp.text}

# Unauthorized
#     Create Session      pixel       http://pixel-api:3333

#     # {email: "papito@ninjapixel.com", password: "pwd123"}
#     # Content-Type: application/json;charset=UTF-8

#     &{payload}=     Create Dictionary   email=papito@ninjapixel.com     password=abc123
#     &{headers}=     Create Dictionary   Content-Type=application/json

#     ${resp}=            Post Request    pixel       /auth   data=${payload}     headers=${headers}
#     Status Should Be    401             ${resp}
#     Log                 ${resp.text}
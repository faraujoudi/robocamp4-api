***Settings***
Documentation       Testes da Rota /auth da Pixel Api

Resource        ../../resources/services.robot

***Test Cases***
Request Token
    # Create Session      pixel       http://pixel-api:3333

    # # {email: "papito@ninjapixel.com", password: "pwd123"}
    # # Content-Type: application/json;charset=UTF-8

    # &{payload}=     Create Dictionary   email=papito@ninjapixel.com     password=pwd123
    # &{headers}=     Create Dictionary   Content-Type=application/json

    # ${resp}=            Post Request    pixel       /auth   data=${payload}     headers=${headers}
    
    ${resp}=            Post Token      papito@ninjapixel.com       pwd123

    Status Should Be    200     ${resp}

Incorret password
    # Create Session      pixel       http://pixel-api:3333

    # # {email: "papito@ninjapixel.com", password: "pwd123"}
    # # Content-Type: application/json;charset=UTF-8

    # &{payload}=     Create Dictionary   email=papito@ninjapixel.com     password=abc123
    # &{headers}=     Create Dictionary   Content-Type=application/json

    # ${resp}=            Post Request    pixel       /auth   data=${payload}     headers=${headers}
    
    ${resp}=            Post Token      papito@ninjapixel.com       abc123

    Status Should Be    401     ${resp}

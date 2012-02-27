Pour tester :

    curl http://localhost:4567/protected # redirection 302
    curl --user bob:12345 http://localhost:4567/protected # acces ok !

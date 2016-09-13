# Project TODO

- Add something to redirect all traffic on port 80 (HTTP) to 443 (HTTPS) since it seems that the Unifi Controller won't do this for us
- Fix Docker logging: Currently, unifi sends all logs to logs/server.log inside the container. (Similarly, the embedded MongoDB logs to logs/mongodb.log)

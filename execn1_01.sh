#!/bin/bash

mv shiny-flask-postgresql_app/_env .env

sudo curl -L \
https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m) \
-o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

#curl -L https://github.com/docker/machine/releases/download/v0.10.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
#chmod +x /tmp/docker-machine && sudo cp /tmp/docker-machine /usr/local/bin/docker-machine

docker swarm init


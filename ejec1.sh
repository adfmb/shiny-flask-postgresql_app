#!/bin/bash

. ./vamb.sh

for N in $(seq 61 63); do
docker-machine create awsn$N                            
docker-machine ssh awsn$N sudo usermod -aG docker ubuntu
done 

aws ec2 authorize-security-group-ingress --group-name docker-machine --protocol -1 --cidr 0.0.0.0/0 

#for N in $(seq 61 63); do
#docker-machine regenerate-certs awsn$N
#done 


#eval $(docker-machine env awsn61)
docker info | grep ^Name

docker-machine ssh awsn61 git clone https://github.com/adfmb/shiny-flask-postgresql_app.git 
docker-machine ssh awsn61 chmod u+x shiny-flask-postgresql_app/execn1_01.sh
docker-machine ssh awsn61 ./shiny-flask-postgresql_app/execn1_01.sh #Este script termina con el swarm inicializado

eval $(docker-machine env awsn61)
docker info | grep ^Name 
TOKEN=$(docker swarm join-token -q manager)
for N in $(seq 62 63); do
  eval $(docker-machine env awsn$N)
  docker info | grep ^Name
  docker swarm join --token $TOKEN $(docker-machine  ip awsn61):2377
done

eval $(docker-machine env awsn61)
docker info | grep ^Name
docker network create --driver overlay dpap1
docker info | grep ^Name
docker network ls

eval $(docker-machine env -u)
docker info | grep ^Name
docker-machine ssh awsn61 docker stack deploy -c shiny-flask-postgresql_app/swarm-docker-compose.yml dpap1


echo "vistar $(docker-machine  ip awsn61):3838"



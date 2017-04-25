Creando el Clúster de Tasks
==============================

# Levantar instancias de AWS

Ejecutar desde la máquina local:

    export MACHINE_DRIVER=amazonec2
    export AWS_ACCESS_KEY_ID=
    export AWS_SECRET_ACCESS_KEY=
    export AWS_DEFAULT_REGION=us-west-2
    for N in $(seq 1 2); do
    docker-machine create awsn$N                            
    docker-machine ssh awsn$N sudo usermod -aG docker ubuntu
    done              

Dado que éste no es un caso de Producción oficial, por practicidad ejecutamos la siguiente instrucción:

     aws ec2 authorize-security-group-ingress --group-name docker-machine --protocol -1 --cidr 0.0.0.0/0 

<br>

**IMPORTANTE: ¡Situarse en el nodo que será Líder!**


# Conectándose al primer nodo

    docker-machine ssh awsn1

# Clonar el repositorio
    
    git clone https://github.com/adfmb/shiny-flask-postgresql_app.git

Cambiar el **_env** por **.env**


# Instalando docker-compose


    sudo curl -L \
    https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m) \
    -o /usr/local/bin/docker-compose


    sudo chmod +x /usr/local/bin/docker-compose

# Instalando docker-machine

    curl -L https://github.com/docker/machine/releases/download/v0.10.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
    chmod +x /tmp/docker-machine && sudo cp /tmp/docker-machine /usr/local/bin/docker-machine

# Inicializando el cluster

    docker swarm init

El *output* debe ser algo parecido a lo siguiente:
 
       docker swarm join \
    --token <poner-token> \
    <poner-ip>

Lo anterior lo copiaremos y pegaremos en los demás nodos (uno en nuestro caso) que formarán parte del clúster.

# Agregar nodo al clúster

**Ahora en otra ventana desde la máquina local, nos conectamos a la otra máquina:**
    
    docker-machine ssh awsn2

**En la máquina 2 (con su respectivo token e ip):**

        docker swarm join \
    --token <poner-token> \
    <poner-ip>

# Haciendo accesible las imágenes para los nodos
**Ahora de regreso en la máquina Líder:**
    
    docker node ls

## Creamos el servicio que nos permitirá guardar las imágenes en el *localhost:5000*

    docker service create --name dpa-registry --publish 5000:5000 registry:2

## Construyendo imágenes y colocándolas en localhost

### bd

    docker-compose build bd
    docker tag shinyflaskpostgresqlapp_bd localhost:5000/shinyflaskpostgresqlapp_bd:v0.1
    docker push localhost:5000/shinyflaskpostgresqlapp_bd

### api

    docker-compose build api
    docker tag shinyflaskpostgresqlapp_api localhost:5000/shinyflaskpostgresqlapp_api:v0.1
    docker push localhost:5000/shinyflaskpostgresqlapp_api

### backend

    docker-compose build backend
    docker tag shinyflaskpostgresqlapp_backend localhost:5000/shinyflaskpostgresqlapp_backend:v0.1
    docker push localhost:5000/shinyflaskpostgresqlapp_backend

curl localhost:5000/v2/_catalog

# Creando la red del clúster

    docker network create --driver overlay dpap1
    docker network ls

# Desplegar el Clúster
    
    docker stack deploy -c swarm-docker-compose.yml dpap1
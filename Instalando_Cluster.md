Instalando Cluster

Situarse en el nodo que será **Líder**

    docker-machine ssh awsn1

#Instalando docker-compose


    sudo curl -L \
    https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m) \
    -o /usr/local/bin/docker-compose


    sudo chmod +x /usr/local/bin/docker-compose

#Instalando docker-machine

    curl -L https://github.com/docker/machine/releases/download/v0.10.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
    chmod +x /tmp/docker-machine && sudo cp /tmp/docker-machine /usr/local/bin/docker-machine

Clonar repositorio de github

docker swarm init

**Ahora en otra ventana desde la máquina local, nos conectamos a la otra máquina:**
    
    docker-machine ssh awsn21

**En la máquina 2 (con su respectivo token e ip):**

        docker swarm join \
    --token SWMTKN-1-2vpc76pzkgytbpo6yfbj4ia8erut7vk4o3al9zeu2hnzyetjou-92pcixnu53nf6vl9awmgo9qqi \
    172.31.20.28:2377

**Ahora de regreso en la máquina Líder:**
    
    docker node ls

Creamos el servicio que nos permitirá guardar las imágenes en el *localhost:5000*

    docker service create --name dpa-registry --publish 5000:5000 registry:2
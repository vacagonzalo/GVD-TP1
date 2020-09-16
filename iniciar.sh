#!/bin/bash
################################################################################
printf "\n"
printf '\e[1;31m%-6s\e[m' "GRANDES VOLUMENES DE DATOS - TP2"
printf "\n"
printf '\e[1;34m%-6s\e[m' "Comienzo la creación de los contenedores"
printf "\n"
docker-compose up -d
printf '\e[1;34m%-6s\e[m' "Espero 10 segundos"
printf "\n"
sleep 10
################################################################################
printf '\e[1;34m%-6s\e[m' "Inicio el replica set del shard alfa"
printf "\n"
docker-compose exec alfa01 sh -c "mongo < /scripts/alfa.js"
################################################################################
printf '\e[1;34m%-6s\e[m' "Inicio el replica set del shard beta"
printf "\n"
docker-compose exec beta01 sh -c "mongo < /scripts/beta.js"
################################################################################
printf '\e[1;34m%-6s\e[m' "Inicio el replica set del shard charlie"
printf "\n"
docker-compose exec charlie01 sh -c "mongo < /scripts/charlie.js"
################################################################################
printf '\e[1;34m%-6s\e[m' "Inicio el replica set de los servidores de configuración"
printf "\n"
docker-compose exec config01 sh -c "mongo --port 27019 < /scripts/config.js"
################################################################################
printf '\e[1;34m%-6s\e[m' "Espero 40 segundos para que se realicen las conexiones internas"
printf "\n"
sleep 40
printf '\e[1;34m%-6s\e[m' "Configuro el router"
printf "\n"
docker-compose exec router sh -c "mongo < /scripts/init-router.js"
################################################################################
docker-compose exec alfa01 sh -c "mongo < /scripts/finanzas.js"
docker-compose exec alfa02 sh -c "mongo < /scripts/slaveOk.js"
docker-compose exec alfa03 sh -c "mongo < /scripts/slaveOk.js"
################################################################################
printf "\n"
printf '\e[1;31m%-6s\e[m' "Se tiene resuelto los puntos 1 y 2 del trabajo práctico"
printf "\n"
################################################################################
docker-compose exec alfa01 sh -c "mongo < /scripts/punto3.js"
printf "\n"
printf '\e[1;31m%-6s\e[m' "Punto 3: 'cliente.region' parece ser un buen candidato a clave de sharding "
printf "\n"
################################################################################
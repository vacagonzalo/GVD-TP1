#!/bin/bash
################################################################################
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
printf '\e[1;34m%-6s\e[m' "Espero 30 segundos para que se realicen las conexiones internas"
printf "\n"
sleep 30

printf '\e[1;34m%-6s\e[m' "Configuro el router"
printf "\n"
docker-compose exec router sh -c "mongo < /scripts/init-router.js"
################################################################################
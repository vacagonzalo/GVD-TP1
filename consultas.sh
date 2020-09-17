#!/bin/bash
docker-compose exec router sh -c "mongo < /scripts/consultas.js"
#!/bin/bash

# Fill necessary data and save file as traefik.env.sh

export EMAIL=
export DOMAIN=
export USERNAME=admin
export HASHED_PASSWORD=$(openssl passwd -apr1 some_your_password)
export TRF_LISTENED_PORT=8080
export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add traefik-public.traefik-public-certificates=true $NODE_ID

export APP_HOSTNAME=

#export KIBANA_HOSTNAME=

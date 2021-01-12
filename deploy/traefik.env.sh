#!/bin/bash

# This is a !DEMO! traefik.env.sh file

export EMAIL=avg@gmail.com
export DOMAIN=135.181.84.149.nip.io
export USERNAME=admin
export HASHED_PASSWORD=$(openssl passwd -apr1 qwe123)
export TRF_LISTENED_PORT=8080
export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add traefik-public.traefik-public-certificates=true $NODE_ID

export APP_HOSTNAME=speedtest.135.181.84.149.nip.io

#export KIBANA_HOSTNAME=kibana.135.181.84.149.nip.io

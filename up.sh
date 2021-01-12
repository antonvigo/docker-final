#!/bin/bash

TRF_NET_NAME=traefik-public
EFK_NET_NAME=efk
source ./deploy/traefik.env.sh

# Build images
docker-compose -f app.compose.yml build
docker-compose -f efk.compose.yml build

# Run Speedtest application stack via docker-compose
#docker-compose -f app.compose.yml -p rbmdkrfinalapp up -d

# Create network for stacks
if (docker network ls -f NAME=$TRF_NET_NAME -q | grep -q ''); then
    echo "Network $TRF_NET_NAME is here!"
else
    docker network create --driver=overlay $TRF_NET_NAME
fi

if (docker network ls -f NAME=$EFK_NET_NAME -q | grep -q ''); then
    echo "Network $EFK_NET_NAME is here!"
else
    docker network create --driver=overlay $EFK_NET_NAME
fi

# Run Speedtest application stack via Swarm
docker stack deploy -c app.compose.yml rbmdkrfinalapp

# Run EFK stack via Swarm
docker stack deploy -c efk.compose.yml rbmdkrfinalefk

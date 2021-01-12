#!/bin/bash

# Stop Speedtest application stack via docker-compose
#docker-compose -f app.compose.yml -p rbmdkrfinalapp down

# Stop Speedtest application stack via Swarm
docker stack rm rbmdkrfinalapp

# Stop EFK stack via Swarm
docker stack rm rbmdkrfinalefk

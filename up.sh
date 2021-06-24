#!/bin/bash

args="'$*'"

containerRepositoryName='docker-whenever'

docker-compose down

# Create container application image with "latest" tag, set "Dockerfile" path,
# change "rails_env_var" variable inside Dockerfile and context path
if [[ "$args" =~ "--prod" ]]; then
  docker build -t $containerRepositoryName:latest .
else
  docker build -t $containerRepositoryName:latest --build-arg bundle_options_var='--without staging production' .
fi

# Execute docker compose to start services described in "docker-compose.yml"
# Adding "-d" hide logs. To show logs execute "docker-compose logs"
docker-compose up -d

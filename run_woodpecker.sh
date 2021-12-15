#!/bin/bash


source .secrets

docker kill woodpecker
docker rm woodpecker
docker run \
  --volume=/home/buildserver/woodpeckerdata/:/var/lib/woodpecker/ \
  --env=WOODPECKER_OPEN=true \
  --env=WOODPECKER_ORGS=linux-chenxing \
  --env=WOODPECKER_REPO_OWNERS=fifteenhex,linux-chenxing \
  --env=WOODPECKER_HOST="https://woodpecker.thingy.jp" \
  --env=WOODPECKER_GITHUB=true \
  --env=WOODPECKER_GITHUB_CLIENT=${WOODPECKER_GITHUB_CLIENT} \
  --env=WOODPECKER_GITHUB_SECRET=${WOODPECKER_GITHUB_SECRET} \
  --env=WOODPECKER_AGENT_SECRET=${WOODPECKER_AGENT_SECRET} \
  --env=WOODPECKER_ADMIN=fifteenhex \
  --publish=8000:8000 \
  --publish=9000:9000 \
  --restart=always \
  --name=woodpecker \
  --detach=true \
  woodpeckerci/woodpecker-server:latest

#!/bin/bash

source .secrets

docker stop woodpecker_agent_gitcdn
docker rm woodpecker_agent_gitcdn
mkdir ~/gitCDN
docker run -d \
	-p 7171:8000 \
	-v $HOME/gitCDN:/git-data \
	-e GITSERVER_UPSTREAM=https://github.com/ \
	-e WORKING_DIRECTORY=/git-data \
	--name woodpecker_agent_gitcdn \
	registry.gitlab.com/grouperenault/git_cdn

docker stop woodpecker_agent
docker rm woodpecker_agent
docker run -d \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  -e WOODPECKER_SERVER="htwo2:9000" \
  -e WOODPECKER_AGENT_SECRET=${WOODPECKER_AGENT_SECRET} \
  -p 3000:3000 \
  --restart always \
  --name woodpecker_agent \
  woodpeckerci/woodpecker-agent:latest

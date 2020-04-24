#!/usr/bin/env bash

set -e
[[ -n $ARTIFACTORY_DOCKER_REGISTRY_USER ]] || (echo "ARTIFACTORY_DOCKER_REGISTRY_USER must be set as an environment variable in CircleCI." && exit 1)
[[ -n $ARTIFACTORY_DOCKER_REGISTRY_PASSWORD ]] || (echo "ARTIFACTORY_DOCKER_REGISTRY_PASSWORD must be set as an environment variable in CircleCI." && exit 1)
# [[ -n $TEAM_EMAIL ]] || (echo "TEAM_EMAIL must be set as an environment variable in CircleCI." && exit 1)
[[ -n $VERSION ]] || (echo "VERSION must be set before invoking this script." && exit 1)

set +x
echo "Tagging containers..."
curl -f -X PUT -u $ARTIFACTORY_DOCKER_REGISTRY_USER:$ARTIFACTORY_DOCKER_REGISTRY_PASSWORD "<manifest.json path>?properties=Retention=1year"
echo "Retention tag complete"
curl -f -X PUT -u $ARTIFACTORY_DOCKER_REGISTRY_USER:$ARTIFACTORY_DOCKER_REGISTRY_PASSWORD "<manifest.json path>?properties=Notification=$TEAM_EMAIL"
echo "Notification tag complete"
curl -f -X PUT -u $ARTIFACTORY_DOCKER_REGISTRY_USER:$ARTIFACTORY_DOCKER_REGISTRY_PASSWORD "<manifest.json path>?properties=App=<project>"
echo "App tag complete"
curl -f -X PUT -u $ARTIFACTORY_DOCKER_REGISTRY_USER:$ARTIFACTORY_DOCKER_REGISTRY_PASSWORD "<manifest.json path>?properties=Function=api"
echo "Function tag complete"
curl -f -X PUT -u $ARTIFACTORY_DOCKER_REGISTRY_USER:$ARTIFACTORY_DOCKER_REGISTRY_PASSWORD "<manifest.json path>?properties=Contact=$TEAM_EMAIL"
echo "Contact tag complete"
echo "Container successfully tagged!"

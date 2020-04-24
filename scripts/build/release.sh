#!/usr/bin/env bash

set -e

# Get version
export VERSION="${CIRCLE_TAG}"
echo ${VERSION}
echo "here in deploy"

# Notify Slack
# curl -X POST -H 'Content-type: application/json' "${SLACK_ROOM_HOOK}" \
# -d @<(cat <<JSON
#   {
#     "text": "Deployment started for ${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}:${VERSION} to ${SDLC}. Last change by ${CIRCLE_USERNAME}"
#   }
# JSON
# )

# echo "AWS Key: ${!AWS_KEY}"

# Login to ECR
export AWS_ACCESS_KEY_ID="${!AWS_KEY}"
export AWS_SECRET_ACCESS_KEY="${!AWS_SECRET}"
export AWS_DEFAULT_REGION="${!REGION}"
eval $(aws ecr get-login --no-include-email --region ${!REGION})


# Get external repo
export REPOSITORY="${!ACCOUNT_ID}.dkr.ecr.${!REGION}.amazonaws.com/<project>-${SDLC}"


# Pull container
docker pull <containers path>
# Tag and push
docker tag <containers path>"${REPOSITORY}:latest"
docker tag <containers path>"${REPOSITORY}:${VERSION}"
docker push "${REPOSITORY}"

# Update ECS and wait for completion
aws ecs update-service --cluster <cluster> --service <service> --force-new-deployment
aws ecs wait services-stable --cluster <cluster> --services <services>

# Notify completion
# curl -X POST -H 'Content-type: application/json' "${SLACK_ROOM_HOOK}" \
# -d  @<(cat <<JSON
#   {
#       "attachments": [
#           {
#               "fallback": "success",
#               "title": "Deploy success :shipit:",
#               "color": "good",
#               "text": "Deployment completed for ${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}:${VERSION} to ${SDLC}."
#           }
#       ]
#   }
# JSON
# )

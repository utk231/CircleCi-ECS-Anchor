#!/usr/bin/env bash


set -ex

# Get version
export VERSION="${CIRCLE_TAG}"

# Notify completion
# curl -X POST -H 'Content-type: application/json' "${SLACK_ROOM_HOOK}" \
# -d  @<(cat <<JSON
#   {
#       "attachments": [
#           {
#               "fallback": "failure",
#               "title": "Deploy failure :sadparrot:",
#               "color": "danger",
#               "text": "Deployment failed for ${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}:${VERSION} to ${SDLC}. Please check ${CIRCLE_BUILD_URL}"
#           }
#       ]
#   }
# JSON
# )

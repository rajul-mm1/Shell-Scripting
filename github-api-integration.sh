#!/bin/bash

###########
# Author - Rajul Mewade
# Date - 4 April 2025
# About - This script will list the users who have access to a particular github repository within an organisation. It is for listing all the collaborators including admins and using github api.
###########

API_URL="https://api.github.com"

USERNAME=$username
TOKEN=$token

REPO_OWNER=$1
REPO_NAME=$2

github_get_api() {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"


    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

list_users_with_read_access() {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    collaborators="$(github_get_api "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    if [[ -z "$collaborators" ]]; then
          echo "No users with read access are found for ${REPO_OWNER}/${REPO_NAME}."
    else
         echo "Users found with read access to ${REPO_OWNER}/${REPO_NAME}."
         echo "$collaborators"
    fi
}

echo "Listing users with read access ${REPO_OWNER}/${REPO_NAME}"
list_users_with_read_access

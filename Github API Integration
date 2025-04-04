#!/bin/bash

###########
# Author - Rajul Mewade
# Date - 4 April 2025
# About - This script will list the users who have access to a particular github repository within an organisation. It is for listing all the collaborators including admins and using github api.
###########

API_URL="https://api.github.com"

Username=$username
Token=$token

repo_owner=$1
repo_name=$2

function github-get-api {
          local endpoint="$1"
          local url="${API_URL}/${endpoint}"


        curl -s -u "${Username}:${Token}" "$url"
}

function list-users-with-read-access{
  local endpoint="repos/${repo_owner}/${repo_user}/collaborators"
  collaborators="$(github-get-api "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

if [[-z "$collaborators"]]; then
  echo "No users with read access are found for ${repo_owner}/${repo_name}."
else
  echo "Users found with read access to ${repo_owner}/${repo_name}."
  echo "$collaborators"
fi

echo "Listing users with read access ${repo_owner}/${repo_name}"
list-users-with-read-access

#!/bin/bash

###########
# Author - Rajul Mewade
# Date - 4 April 2025
# About - This script will list the users who have access to a particular github repository within an organisation. It is for listing all the collaborators including admins and using github api.
###########

helper()

# Github API URL
API_URL="https://api.github.com"

# Github username and personal access token. We need our username and token which is private
USERNAME=$username
TOKEN=$token

# User information and repository information
REPO_OWNER=$1
REPO_NAME=$2

# function for making GET request to github api
github_get_api() {
    local endpoint="$1"    # endpoint is the entry point for the API requests by client applications to interact and access API's functionalities and resources
    local url="${API_URL}/${endpoint}"


    curl -s -u "${USERNAME}:${TOKEN}" "$url"   # curl is used for making requests
}

# function for listing users who have read access
list_users_with_read_access() {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    collaborators="$(github_get_api "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # -z flag will check whether the string is empty or not
    if [[ -z "$collaborators" ]]; then
          echo "No users with read access are found for ${REPO_OWNER}/${REPO_NAME}."
    else
         echo "Users found with read access to ${REPO_OWNER}/${REPO_NAME}."
         echo "$collaborators"
    fi
}

# this function checks for the no of arguments that we provide while calling the script
helper() {
   expected_cmd_args=2
   if [ $# -ne $expected_cmd_args ]; then
     echo "enter the exact no of arguments"
     echo "asd"
}

# main script
echo "Listing users with read access ${REPO_OWNER}/${REPO_NAME}"
list_users_with_read_access        # calling function


Steps for executing the script:
1. First clone your repository wherever you want
2. Then export username and token using commands --> export username="your_username" export token="your_personal_access_token"
3. Then run the script using the command --> ./script_name repo_owner_name your_repo_name

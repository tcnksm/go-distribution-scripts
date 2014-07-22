#!/bin/bash

# If you prepare version.go
# VERSION=$(grep "const Version " version.go | sed -E 's/.*"(.+)"$/\1/')
if [ -z "${VERSION}" ]; then
    echo "Please specify a version."
    exit 1
fi

if [ -z "${REPO}" ]; then
    echo "Please set your Repository name in the REPO env var."
    exit 1
fi

if [ -z "${GITHUB_TOKEN}" ]; then
    echo "Please set your GITHUB API Token in the GITHUB_TOKEN env var."
    exit 1
fi

if [ -z "${OWNER}" ]; then
    OWNER=`git config --global user.name`
    if [ -z "${OWNER}" ]; then        
        echo "Please set your GITHUB API Token in the GITHUB_TOKEN env var."
        exit 1
    fi 
fi

DIR=$(cd $(dirname ${0})/.. && pwd)
cd ${DIR}

INPUT="
{
    \"tag_name\": \"${VERSION}\",
    \"target_commitish\": \"master\",
    \"draft\": false,
    \"prerelease\": false
}"

RELEASE_RESPONSE=$(
    curl --fail -X POST https://api.github.com/repos/${OWNER}/${REPO}/releases \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Content-Type: application/json" \
    -d "${INPUT}")

echo $RELEASE_RESPONSE | jq ".id" > .GITHUB_RELEASE_ID

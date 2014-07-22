#!/bin/bash

DIR=$(cd $(dirname ${0})/.. && pwd)
cd ${DIR}

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

if [ ! -f .GITHUB_RELEASE_ID ]; then
    echo "Please create relase with scripts/github-create-relase.sh."
    exit 1
fi


ID=$(cat .GITHUB_RELEASE_ID)
for ARCHIVE in ./pkg/dist/*; do
    ARCHIVE_NAME=$(basename ${ARCHIVE})
    CONTENT_TYPE=$(file --mime-type -b ${ARCHIVE})

    echo Uploading: ${ARCHIVE_NAME}
    RESPONSE=$(
        curl --fail -X POST https://uploads.github.com/repos/${OWNER}/${REPO}/releases/${ID}/assets?name=${ARCHIVE_NAME} \
            -H "Accept: application/vnd.github.v3+json" \
            -H "Authorization: token ${GITHUB_TOKEN}" \
            -H "Content-Type: ${CONTENT_TYPE}" \
            --data-binary @"${ARCHIVE}"
        )
done

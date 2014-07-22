#!/bin/bash
set -e

# If you prepare version.go
# VERSION=$(grep "const Version " version.go | sed -E 's/.*"(.+)"$/\1/')
if [ -z "${VERSION}" ]; then
    echo "Please specify a version."
    exit 1
fi

if [ -z "${BINTRAY_API_KEY}" ]; then
    echo "Please set your bintray API key in the BINTRAY_API_KEY env var."
    exit 1
fi

if [ -z "${REPO}" ]; then
    echo "Please set your Repository name in the REPO env var."
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

for ARCHIVE in ./pkg/dist/*; do
    ARCHIVE_NAME=$(basename ${ARCHIVE})

    echo Uploading: ${ARCHIVE_NAME}
    curl \
        -T ${ARCHIVE} \
        -u${OWNER}:${BINTRAY_API_KEY} \
        "https://api.bintray.com/content/${OWNER}/${REPO}/${REPO}/${VERSION}/${ARCHIVE_NAME}"
done

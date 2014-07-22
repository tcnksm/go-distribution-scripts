#!/bin/bash
set -e

DIR=$(cd $(dirname ${0})/.. && pwd)
cd ${DIR}

# If you prepare version.go
# VERSION=$(grep "const Version " version.go | sed -E 's/.*"(.+)"$/\1/')
if [ -z "${VERSION}" ]; then
    echo "Please specify a version."
    exit 1
fi

if [ -z "${APP_NAME}" ]; then
    echo "Please set your Application name in the APP_NAME env var."
    exit 1
fi

# Run Compile
./scripts/compile.sh


if [ -d pkg ];
    rm -rf ./pkg/dist
fi 

# Package all binary as .zip
mkdir -p ./pkg/dist
for PLATFORM in $(find ./pkg -mindepth 1 -maxdepth 1 -type d); do
    PLATFORM_NAME=$(basename ${PLATFORM})
    ARCHIVE_NAME=${APP_NAME}_${VERSION}_${PLATFORM_NAME}

    if [ $PLATFORM_NAME = "dist" ]; then
        continue
    fi

    pushd ${PLATFORM}
    zip ${DIR}/pkg/dist/${ARCHIVE_NAME}.zip ./*
    popd
done

# Generate shasum
pushd ./pkg/dist
shasum * > ./${VERSION}_SHASUMS
popd

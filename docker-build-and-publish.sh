#!/bin/bash

TAG="${1}"
REPO="gcr.io/valued-throne-148713/24go-arena-docker";

usage() {
    echo "Usage: $0 [VERSION|x.x.x]";
}

if [ -z "$TAG" ]; then
    usage;
    exit -1;
fi

echo "[i] Building multi-arch image for tag ${TAG} and pushing to repo";
docker buildx build -f Dockerfile --platform linux/amd64,linux/arm64 -t "${REPO}:${TAG}" . --push;

if [[ "$?" != "0" ]]; then
    echo "[!] Failed, cancelling tagging latest";
    exit $?;
fi

echo "[i] Tagging latest and pushing to repo"
docker buildx build -f Dockerfile --platform linux/amd64,linux/arm64 -t "${REPO}:latest" . --push;

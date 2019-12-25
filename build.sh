#!/bin/bash

set -e

BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ $BRANCH == "master" ]
then
    HADOOP_VERSION="3.2.1"
    IMAGE_TAG="latest"
else
    HADOOP_VERSION="$(echo $BRANCH | cut -d'-' -f1)"
    IMAGE_TAG=$BRANCH
fi

build() {
    NAME=$1
    IMAGE_TAG=$2
    HADOOP_VERSION=$3
    IMAGE=nvtienanh/hadoop-$NAME:$IMAGE_TAG
    cd $([ -z "$1" ] && echo "./$NAME" || echo "$1")
    echo '--------------------------' building $IMAGE in $(pwd)
    docker build \
     -t $IMAGE \
     --build-arg IMAGE_TAG=$IMAGE_TAG \
     --build-arg HADOOP_VERSION=$HADOOP_VERSION .
    cd -
}


build base
# build worker
# build submit
# build java-template template/java
# build scala-template template/scala
# build python-template template/python
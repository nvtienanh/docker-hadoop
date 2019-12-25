#!/bin/bash
set -e

if [ $# -eq 0 ]
    then
        BRANCH=$(git rev-parse --abbrev-ref HEAD)
    else
        BRANCH=$1
fi

if [ $BRANCH == "master" ]
then
    HADOOP_VERSION="3.2.1"
    IMAGE_TAG="latest"
else
    HADOOP_VERSION="$(echo $BRANCH | cut -d'-' -f1)"
    IMAGE_TAG=$BRANCH
fi

echo $BRANCH

deploy() {
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
    docker push $IMAGE
}


deploy base $IMAGE_TAG $HADOOP_VERSION
deploy datanode $IMAGE_TAG $HADOOP_VERSION
deploy historyserver $IMAGE_TAG $HADOOP_VERSION
deploy namenode $IMAGE_TAG $HADOOP_VERSION
deploy nodemanager $IMAGE_TAG $HADOOP_VERSION
deploy resourcemanager $IMAGE_TAG $HADOOP_VERSION
deploy submit $IMAGE_TAG $HADOOP_VERSION

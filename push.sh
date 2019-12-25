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

push() {
    NAME=$1
    IMAGE_TAG=$2
    HADOOP_VERSION=$3
    IMAGE=nvtienanh/hadoop-$NAME:$IMAGE_TAG

    docker push $IMAGE
}


push base $IMAGE_TAG $HADOOP_VERSION
push datanode $IMAGE_TAG $HADOOP_VERSION
push historyserver $IMAGE_TAG $HADOOP_VERSION
push namenode $IMAGE_TAG $HADOOP_VERSION
push nodemanager $IMAGE_TAG $HADOOP_VERSION
push resourcemanager $IMAGE_TAG $HADOOP_VERSION
push submit $IMAGE_TAG $HADOOP_VERSION
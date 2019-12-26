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
     --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
     --build-arg VCS_REF=`git rev-parse --short HEAD` \
     --build-arg HADOOP_VERSION=$HADOOP_VERSION .
    cd -
    # docker push $IMAGE
}


deploy base $IMAGE_TAG $HADOOP_VERSION
# Update Microbadger
# curl -X POST https://hooks.microbadger.com/images/nvtienanh/hadoop-base/CA79IP9AVi0mpSaTDfi9k4POrdQ=

# deploy datanode $IMAGE_TAG $HADOOP_VERSION
# Update Microbadger
# curl -X POST https://hooks.microbadger.com/images/nvtienanh/hadoop-datanode/5ywILupr2x_pM8iQHWpzuT2Vo5o=

# deploy historyserver $IMAGE_TAG $HADOOP_VERSION
# Update Microbadger
# curl -X POST https://hooks.microbadger.com/images/nvtienanh/hadoop-historyserver/Nz4tPWfDxUIQOblKmoX4BD2tUDI=

# deploy namenode $IMAGE_TAG $HADOOP_VERSION
# Update Microbadger
# curl -X POST https://hooks.microbadger.com/images/nvtienanh/hadoop-namenode/PUFKrZ3S64gLZZJ0CClxrzSs4DY=

# deploy nodemanager $IMAGE_TAG $HADOOP_VERSION
# Update Microbadger
# curl -X POST https://hooks.microbadger.com/images/nvtienanh/hadoop-nodemanager/8WV-SL8Isz9Q33XWDBNmftzorMY=

# deploy resourcemanager $IMAGE_TAG $HADOOP_VERSION
# Update Microbadger
# curl -X POST https://hooks.microbadger.com/images/nvtienanh/hadoop-resourcemanager/C4XFnEu-_78wvUSbu9zW3Ieuilk=

# deploy submit $IMAGE_TAG $HADOOP_VERSION
# # Update Microbadger
# curl -X POST https://hooks.microbadger.com/images/nvtienanh/hadoop-base/CA79IP9AVi0mpSaTDfi9k4POrdQ=

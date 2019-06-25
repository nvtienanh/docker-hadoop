#!/bin/bash

hadoop fs -mkdir -p hdfs://namenode:9000/user/nvtienanh/input-data

hadoop fs -copyFromLocal /opt/hadoop/applications/app/input-data hdfs://namenode:9000/user/nvtienanh

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-$HADOOP_VERSION.jar \
    -file /opt/hadoop/applications/app/src/mapper.py \
    -mapper /opt/hadoop/applications/app/src/mapper.py \
    -file /opt/hadoop/applications/app/src/reducer.py  \
    -reducer /opt/hadoop/applications/app/src/reducer.py  \
    -input hdfs://namenode:9000/user/nvtienanh/input-data/daily.csv \
    -output hdfs://namenode:9000/user/nvtienanh/output-data

hadoop fs -cat hdfs://namenode:9000/user/nvtienanh/output-data/*

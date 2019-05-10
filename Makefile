DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
HADOOP_TAG := 3.2.0-debian
HADOOP_VERSION := 3.2.0

build:
	docker build -t nvtienanh/hadoop-base:$(HADOOP_TAG) ./base
	docker build -t nvtienanh/hadoop-namenode:$(HADOOP_TAG) ./namenode
	docker build -t nvtienanh/hadoop-datanode:$(HADOOP_TAG) ./datanode
	docker build -t nvtienanh/hadoop-resourcemanager:$(HADOOP_TAG) ./resourcemanager
	docker build -t nvtienanh/hadoop-nodemanager:$(HADOOP_TAG) ./nodemanager
	docker build -t nvtienanh/hadoop-historyserver:$(HADOOP_TAG) ./historyserver
	docker build -t nvtienanh/hadoop-submit:$(HADOOP_TAG) ./submit

push:
	docker push nvtienanh/hadoop-base:$(HADOOP_TAG)
	docker push nvtienanh/hadoop-namenode:$(HADOOP_TAG)
	docker push nvtienanh/hadoop-datanode:$(HADOOP_TAG)
	docker push nvtienanh/hadoop-resourcemanager:$(HADOOP_TAG)
	docker push nvtienanh/hadoop-nodemanager:$(HADOOP_TAG)
	docker push nvtienanh/hadoop-historyserver:$(HADOOP_TAG)
	docker push nvtienanh/hadoop-submit:$(HADOOP_TAG)

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} nvtienanh/hadoop-base:$(HADOOP_TAG) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} nvtienanh/hadoop-base:$(HADOOP_TAG) hdfs dfs -copyFromLocal /opt/hadoop-$(HADOOP_VERSION )/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} nvtienanh/hadoop-base:$(HADOOP_TAG) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} nvtienanh/hadoop-base:$(HADOOP_TAG) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} nvtienanh/hadoop-base:$(HADOOP_TAG) hdfs dfs -rm -r /input

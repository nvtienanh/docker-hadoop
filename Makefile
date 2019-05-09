DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
TAG := 3.2.0-debian
build:
	docker build -t nvtienanh/hadoop-base:$(TAG) ./base
	docker build -t nvtienanh/hadoop-namenode:$(TAG) ./namenode
	docker build -t nvtienanh/hadoop-datanode:$(TAG) ./datanode
	docker build -t nvtienanh/hadoop-resourcemanager:$(TAG) ./resourcemanager
	docker build -t nvtienanh/hadoop-nodemanager:$(TAG) ./nodemanager
	docker build -t nvtienanh/hadoop-historyserver:$(TAG) ./historyserver
	docker build -t nvtienanh/hadoop-submit:$(TAG) ./submit

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} nvtienanh/hadoop-base:$(TAG) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} nvtienanh/hadoop-base:$(TAG) hdfs dfs -copyFromLocal /opt/hadoop-3.2.0/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} nvtienanh/hadoop-base:$(TAG) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} nvtienanh/hadoop-base:$(TAG) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} nvtienanh/hadoop-base:$(TAG) hdfs dfs -rm -r /input

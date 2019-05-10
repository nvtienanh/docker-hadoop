[![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/big-data-europe/Lobby)
[![Build Status](https://travis-ci.org/nvtienanh/docker-hadoop.svg?branch=master)](https://travis-ci.org/nvtienanh/docker-hadoop)

# Changes

Version 2.0.0 introduces uses wait_for_it script for the cluster startup

# Hadoop Docker

## Supported Hadoop Versions
See repository branches for supported hadoop versions

## Quick Start

To deploy an example HDFS cluster, run:
```
  docker-compose up -d
```

Run example wordcount job:
```
  make wordcount
```

Or deploy in swarm:
```
docker stack deploy -c docker-compose-v3.yml hadoop
```

`docker-compose` creates a docker network that can be found by running `docker network list`, e.g. `dockerhadoop_default`.

Run `docker network inspect` on the network (e.g. `docker-hadoop_default`) to find the IP the hadoop interfaces are published on. Access these interfaces with the following URLs:

* Namenode: http://localhost:9870/dfshealth.html#tab-overview
* History server: http://localhost:8188/applicationhistory
* Datanode: http://localhost:9864/
* Nodemanager: http://localhost:8042/node
* Resource manager: http://localhost:8088/

## Configure Environment Variables

The configuration parameters can be specified in the hadoop.env file or as environmental variables for specific services (e.g. namenode, datanode etc.):
```
  CORE_CONF_fs_defaultFS=hdfs://namenode:8020
```

CORE_CONF corresponds to core-site.xml. fs_defaultFS=hdfs://namenode:8020 will be transformed into:
```
  <property><name>fs.defaultFS</name><value>hdfs://namenode:8020</value></property>
```
To define dash inside a configuration parameter, use triple underscore, such as YARN_CONF_yarn_log___aggregation___enable=true (yarn-site.xml):
```
  <property><name>yarn.log-aggregation-enable</name><value>true</value></property>
```

The available configurations are:
* /etc/hadoop/core-site.xml CORE_CONF
* /etc/hadoop/hdfs-site.xml HDFS_CONF
* /etc/hadoop/yarn-site.xml YARN_CONF
* /etc/hadoop/httpfs-site.xml HTTPFS_CONF
* /etc/hadoop/kms-site.xml KMS_CONF
* /etc/hadoop/mapred-site.xml  MAPRED_CONF

If you need to extend some other configuration file, refer to base/entrypoint.sh bash script.

## Liên hệ
* Anh Nguyen [@nvtienanh](https://github.com/nvtienanh) 

## Tham khảo
* [Big Data Europe](https://github.com/big-data-europe/)

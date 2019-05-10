ARG HADOOP_BASE=3.2.0-debian
FROM nvtienanh/hadoop-base:${HADOOP_BASE}
LABEL MAINTAINER = "Anh Nguyen <nvtienanh@gmail.com>" 

HEALTHCHECK CMD curl -f http://localhost:8188/ || exit 1

ENV YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=/hadoop/yarn/timeline
RUN mkdir -p /hadoop/yarn/timeline
VOLUME /hadoop/yarn/timeline

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8188

CMD ["/run.sh"]

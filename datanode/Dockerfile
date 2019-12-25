ARG IMAGE_TAG
FROM nvtienanh/hadoop-base:${IMAGE_TAG}
LABEL MAINTAINER = "Anh Nguyen <nvtienanh@gmail.com>" 

HEALTHCHECK CMD curl -f http://localhost:9864/ || exit 1

ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 9864

CMD ["/run.sh"]

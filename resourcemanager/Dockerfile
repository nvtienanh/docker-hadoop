ARG IMAGE_TAG
FROM nvtienanh/hadoop-base:${IMAGE_TAG}

ARG HADOOP_VERSION
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="Apache Hadoop" \
        org.label-schema.description="Apache Hadoop docker image based on Debian Linux" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="https://github.com/nvtienanh/docker-hadoop/tree/master/datanode" \
        org.label-schema.vendor="nvtienanh" \
        org.label-schema.version=$HADOOP_VERSION \
        org.label-schema.schema-version="1.0"

HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8088

CMD ["/run.sh"]

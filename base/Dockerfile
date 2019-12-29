FROM nvtienanh/oracle-jdk:debian9

ARG HADOOP_VERSION
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="Apache Hadoop" \
        org.label-schema.description="Apache Hadoop docker image based on Debian Linux" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="https://github.com/nvtienanh/docker-hadoop/tree/master/base" \
        org.label-schema.vendor="nvtienanh" \
        org.label-schema.version=$HADOOP_VERSION \
        org.label-schema.schema-version="1.0"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      net-tools \
      curl \
      netcat \
      gnupg \
    #   wget \
    && rm -rf /var/lib/apt/lists/*
      

RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS

RUN gpg --import KEYS

ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

# Develop mode
# COPY hadoop-3.2.1.tar.gz /tmp/hadoop.tar.gz
# RUN set -x \
#     # && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
#     && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
#     && gpg --verify /tmp/hadoop.tar.gz.asc \
#     && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
#     && rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop/etc/hadoop /etc/hadoop
RUN mkdir /opt/hadoop/logs

RUN mkdir /hadoop-data

ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH $HADOOP_HOME/bin/:$PATH

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

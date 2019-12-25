FROM alpine:3.9

LABEL maintainer = "Anh Nguyen <nvtienanh@gmail.com>"

ARG HADOOP_VERSION

# Replace the apk repositories for a better performance
RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories

# Update the package list
RUN apk update

RUN apk add --no-cache openjdk8 \
    net-tools \
    curl \
    # netcat \
    gnupg \
    # wget \
    bash \
    perl \
    && rm -rf /var/cache/apk/*

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS

RUN gpg --import KEYS

ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /tmp/ \
    && mv /tmp/hadoop-$HADOOP_VERSION /opt/hadoop \
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

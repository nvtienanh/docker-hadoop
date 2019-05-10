ARG HADOOP_BASE=3.2.0-debian
FROM nvtienanh/hadoop-base:${HADOOP_BASE}
LABEL MAINTAINER = "Anh Nguyen <nvtienanh@gmail.com>" 

HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8088

CMD ["/run.sh"]

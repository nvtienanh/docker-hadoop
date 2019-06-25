ARG HADOOP_BASE=3.2.0-debian
FROM nvtienanh/hadoop-base:${HADOOP_BASE}
LABEL MAINTAINER = "Anh Nguyen <nvtienanh@gmail.com>" 

# COPY WordCount.jar /opt/hadoop/applications/WordCount.jar

# ENV JAR_FILEPATH="/opt/hadoop/applications/WordCount.jar"
# ENV CLASS_TO_RUN="WordCount"
# ENV PARAMS="/input /output"

ADD app  /opt/hadoop/applications/app

ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]

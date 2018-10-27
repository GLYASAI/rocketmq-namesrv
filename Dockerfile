FROM openjdk:8-jdk-alpine
LABEL maintainer=huangrh@goodrain.com

ARG ROCKETMQ_VERSION=4.3.0
ARG ROCKETMQ_HOME=/export/servers/rocketmq
ARG BASE_URL=http://mirror.bit.edu.cn/apache/rocketmq

RUN apk add --no-cache curl tar bash procps
RUN mkdir -p ${ROCKETMQ_HOME} \
  && curl -fsSL -o /tmp/rocketmq.zip ${BASE_URL}/${ROCKETMQ_VERSION}/rocketmq-all-${ROCKETMQ_VERSION}-bin-release.zip \
  && unzip -o /tmp/rocketmq.zip -d ${ROCKETMQ_HOME} \
  && mv ${ROCKETMQ_HOME}/rocketmq-all*/* ${ROCKETMQ_HOME} \
  && rm -rf ${ROCKETMQ_HOME}/rocketmq-all* \
  && rm -f /tmp/rocketmq.zip
  
VOLUME ${ROCKETMQ_HOME}/data

WORKDIR ${ROCKETMQ_HOME}/bin

EXPOSE 9876

ENTRYPOINT ["sh", "mqnamesrv"]

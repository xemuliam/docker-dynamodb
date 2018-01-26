FROM       xemuliam/oracle-jdk
MAINTAINER Viacheslav Kalashnikov <xemuliam@gmail.com>
ARG        DIST_MIRROR=https://s3.eu-central-1.amazonaws.com/dynamodb-local-frankfurt
ARG        VERSION=latest
ENV        DYNAMODB_HOME=/opt/dynamodb
RUN        apk add --no-cache --virtual=.build-deps curl && \
           mkdir -p ${DYNAMODB_HOME} && \
           curl ${DIST_MIRROR}/dynamodb_local_${VERSION}.tar.gz | tar xvz -C ${DYNAMODB_HOME} && \
           rm -f *.tar.gz && \
           apk del .build-deps
COPY       ./start_dynamodb.sh ${DYNAMODB_HOME}/
RUN        chmod +x ${DYNAMODB_HOME}/start_dynamodb.sh
EXPOSE     8000
VOLUME     ${DYNAMODB_HOME}/dynamodb_local_db
WORKDIR    ${DYNAMODB_HOME}
ENTRYPOINT ["./start_dynamodb.sh"]
CMD        ["-dbPath", "./dynamodb_local_db", "-sharedDb"]


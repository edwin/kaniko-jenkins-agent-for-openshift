FROM gcr.io/kaniko-project/executor:v1.7.0-debug AS kaniko

FROM jenkins/inbound-agent:3273.v4cfe589b_fd83-1
USER root

COPY --from=kaniko /kaniko/executor /kaniko/executor

RUN chgrp -R 0 /kaniko/ && \
    chmod -R g=u /kaniko/

USER 127

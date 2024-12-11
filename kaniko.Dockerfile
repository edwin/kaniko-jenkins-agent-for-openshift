FROM gcr.io/kaniko-project/executor:v1.7.0-debug AS kaniko

FROM registry.redhat.io/openshift4/ose-jenkins-agent-base:latest
USER root

COPY --from=kaniko /kaniko/executor /kaniko/executor

RUN chgrp -R 0 /kaniko/ && \
    chmod -R g=u /kaniko/

USER 127

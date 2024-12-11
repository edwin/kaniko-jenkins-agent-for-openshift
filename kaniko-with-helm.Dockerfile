FROM gcr.io/kaniko-project/executor:v1.7.0-debug AS kaniko

FROM registry.redhat.io/openshift4/ose-jenkins-agent-base:latest
USER root

COPY --from=kaniko /kaniko/executor /kaniko/executor

RUN chgrp -R 0 /kaniko/ && \
    chmod -R g=u /kaniko/

RUN curl -fsSL -o /tmp/get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod 700 /tmp/get_helm.sh && cd /tmp/ && ./get_helm.sh  && rm -Rf /tmp/*
RUN helm version

USER 127
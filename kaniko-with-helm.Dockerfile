FROM gcr.io/kaniko-project/executor:v1.7.0-debug AS kaniko

FROM jenkins/inbound-agent:3273.v4cfe589b_fd83-1
USER root

COPY --from=kaniko /kaniko/executor /kaniko/executor

RUN chgrp -R 0 /kaniko/ && \
    chmod -R g=u /kaniko/

RUN curl -fsSL -o /tmp/get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod 700 /tmp/get_helm.sh && cd /tmp/ && ./get_helm.sh  && rm -Rf /tmp/*
RUN helm version

USER 127
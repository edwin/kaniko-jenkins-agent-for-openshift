FROM jenkins/inbound-agent:3273.v4cfe589b_fd83-1
USER root

RUN curl -fsSL -o /tmp/get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod 700 /tmp/get_helm.sh && cd /tmp/ && ./get_helm.sh  && rm -Rf /tmp/*
RUN helm version

RUN curl https://github.com/rancher/cli/releases/download/v2.10.1-rc.1/rancher-linux-amd64-v2.10.1-rc.1.tar.gz -o /tmp/rancher-linux-amd64-v2.10.1-rc.1.tar.gz -L

RUN tar -xf /tmp/rancher-linux-amd64-v2.10.1-rc.1.tar.gz -C /tmp &&  mv /tmp/rancher*/rancher /tmp/rancher && ln -s /tmp/rancher /usr/bin/rancher
RUN rancher --version

RUN curl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /tmp/kubectl -L  && ls -alrth /tmp  && chmod +x /tmp/kubectl  && ln -s /tmp/kubectl /usr/bin/kubectl
RUN kubectl version --client

USER 127